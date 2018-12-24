import Foundation
struct ResponseBase : Codable {
	let help : String?
	let success : Bool?
	let result : Result?

	enum CodingKeys: String, CodingKey {

		case help = "help"
		case success = "success"
		case result = "result"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		help = try values.decodeIfPresent(String.self, forKey: .help)
		success = try values.decodeIfPresent(Bool.self, forKey: .success)
		result = try values.decodeIfPresent(Result.self, forKey: .result)
	}

}
