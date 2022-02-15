//
//  User.swift
//  TableViewTest
//
//  Created by Raphaël Goupille on 22/01/2022.
//

import Foundation

struct FabulaUser: Equatable {
    
    var userName: String
    var userId: String
    var userEmail: String
    
    static func == (lhs: FabulaUser, rhs: FabulaUser) -> Bool {
        return lhs.userName == rhs.userName &&
        lhs.userId == rhs.userId &&
        lhs.userEmail == rhs.userEmail
    }
}
