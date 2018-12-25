//
//  RequestManager.swift
//  Mobile Data
//
//  Created by Aung Phyoe on 24/12/18.
//  Copyright © 2018 Aung Phyoe. All rights reserved.
//

import Foundation
class RequestManager: NSObject {
    override init() {
        let memoryCapacity = 500 * 1024 * 1024
        let diskCapacity = 500 * 1024 * 1024
        let cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "myDataPath")
        URLCache.shared = cache
    }
    static var defaultTimeoutInterval: TimeInterval = 60
    fileprivate func getRequest(_ url: URL, timeoutInterval: TimeInterval = RequestManager.defaultTimeoutInterval) -> NSMutableURLRequest {
        let theRequest = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: timeoutInterval)
        theRequest.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        theRequest.httpMethod = "GET"
        return theRequest
    }
    fileprivate func session(_ url: URL) -> URLSession {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .useProtocolCachePolicy
        config.urlCache = nil
        var session = URLSession(configuration: config, delegate: nil, delegateQueue: nil)
        if let urlScheme = url.scheme {
            if urlScheme == "https" {
                session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
            }
        }
        return session
    }
    func get(urlString: String,
             completion: @escaping (Bool, [AnyHashable: Any]?, NSError?) -> Void ) {
        if let url = URL(string: urlString) {
            let session = self.session(url)
            let cache = URLCache.shared
            let request = self.getRequest(url) as URLRequest
            if let data = cache.cachedResponse(for: request)?.data {
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [AnyHashable: Any] {
                    completion(true, json, nil)
                } else {
                    completion(false, nil, NSError(domain: "error", code: 3, userInfo: ["message": "Response error"]))
                }
            } else {
                session.dataTask(with: request, completionHandler: { (data, response, error) in
                    DispatchQueue.main.async {
                        if data != nil {
                            if let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [AnyHashable: Any] {
                                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                                    let cachedData = CachedURLResponse(response: response, data: data!)
                                    cache.storeCachedResponse(cachedData, for: request)
                                    completion(true, json, nil)
                                } else {
                                    completion(false, json, NSError(domain: "error", code: 3, userInfo: ["message": "Response error"]))
                                }
                            }
                        } else {
                            completion(false, nil, NSError(domain: "error", code: 2, userInfo: ["message": "Response data is null"]))
                        }
                    }
            }).resume()
            }
           
        } else {
            completion(false, nil, NSError(domain: "error", code: 1, userInfo: ["message": "Response error"]))
        }
    }
}
extension RequestManager: URLSessionTaskDelegate {
    public func urlSession(_ session: URLSession,
                           didReceive challenge: URLAuthenticationChallenge,
                           completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void) {
        guard challenge.previousFailureCount == 0 else {
            challenge.sender?.cancel(challenge)
            // Inform the user that the user name and password are incorrect
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        let protectSpace = challenge.protectionSpace
        if let sender = challenge.sender {
            if protectSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
                //TRUST invalid HTTPS://
                if let trust = protectSpace.serverTrust {
                    let cred = URLCredential(trust: trust)
                    sender.use(cred, for: challenge)
                    completionHandler(.useCredential, cred)
                    return
                }
            }
            sender.performDefaultHandling!(for: challenge)
        }
    }
}
