//
//  User.swift
//  summer_school_jokes
//
//  Created by admin on 12.07.2024.
//

import Foundation


struct User: Identifiable, Codable {
    let id: Int
    let username: String
    let email: String
//    var avatar: String = "ava"
    let password: String
    let is_admin: Bool
    
    
//    var initials: String {
//        let formatter = PersonNameComponentsFormatter ()
//        if let components = formatter.personNameComponents (from: fullname) {
//            formatter.style = .abbreviated
//            return formatter.string(from: components)
//        }
//        return ""
//    }
}

extension User {
    static var MOCK_USER = User(id: 0, username: "MesserMMP", email: "messermmp@gmail.com", password: "IMG_3597", is_admin: false)
}
