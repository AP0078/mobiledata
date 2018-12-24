import Foundation
struct Links: Codable {
	let start: String?
    let prev: String?
	let next: String?
	enum CodingKeys: String, CodingKey {
		case start = "start"
        case prev = "prev"
		case next = "next"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		start = try values.decodeIfPresent(String.self, forKey: .start)
        prev = try values.decodeIfPresent(String.self, forKey: .prev)
		next = try values.decodeIfPresent(String.self, forKey: .next)
	}
}
