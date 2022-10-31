//
//  User.swift
//  Test
//
//  Created by Reyhan on 31/10/22.
//

import Foundation


class UserWrapper: Codable{
    var data: User!
}

class User: Codable{
    var id: Int!
    var email: String!
    var firstName: String!
    var lastName: String!
    var avatar: String!
    
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case email = "email"
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar = "avatar"
    }
}
