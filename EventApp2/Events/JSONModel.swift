////


import Foundation

struct Events : Codable {
    let event : Event?
}
struct Event : Codable {
    let field_logo : Field_logo?
    let title : String
    let body : String?
    let field_date : String?
    let field_location : String?
}

struct Field_logo : Codable {
    let src : String?
    let alt : String?
}

struct Json4Swift_Base : Codable {
    let events : [Events]?
    
    enum CodingKeys: String, CodingKey {
        
        case events = "events"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        events = try values.decodeIfPresent([Events].self, forKey: .events)
    }
    
}
