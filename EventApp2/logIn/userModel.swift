//
//  userModel.swift
//  EventApp2
//
//  Created by Bdoor on 23/09/1440 AH.
//  Copyright © 1440 badriah. All rights reserved.
//

import Foundation

struct User:Codable {
    let result:String?
    let resultError:String?
    let userInfo:UserInfo?
}
struct UserInfo:Codable {
    let userName:String?
    let userEmail:String?
    let userPhoneNumber:String?
}
struct UserModell : Codable {
    let user : [User]?
    
    enum CodingKeys: String, CodingKey {
        
        case user = "user"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        user = try values.decodeIfPresent([User].self, forKey: .user)
    }
    
}
