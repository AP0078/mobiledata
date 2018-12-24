import Foundation
struct Result: Codable {
	let resource_id: String?
	let fields: [Fields]?
	let records: [Records]?
	let links: Links?
	let limit: Int?
	let total: Int?
	enum CodingKeys: String, CodingKey {
		case resource_id = "resource_id"
		case fields = "fields"
		case records = "records"
		case links = "_links"
		case limit = "limit"
		case total = "total"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		resource_id = try values.decodeIfPresent(String.self, forKey: .resource_id)
		fields = try values.decodeIfPresent([Fields].self, forKey: .fields)
		records = try values.decodeIfPresent([Records].self, forKey: .records)
		links = try values.decodeIfPresent(Links.self, forKey: .links)
		limit = try values.decodeIfPresent(Int.self, forKey: .limit)
		total = try values.decodeIfPresent(Int.self, forKey: .total)
	}
}
