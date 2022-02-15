//
//  FakeAuthData.swift
//  FabulaTests
//
//  Created by Raphaël Goupille on 15/02/2022.
//

import Foundation
@testable import Fabula

final class FakeAuthData {
    
    class NetworkError: Error {}
    static let networkError = NetworkError()
    
    static let fakeUser = FabulaUser(userName: "bob", userId: "1", userEmail: "bob@gmail.com")
    

}
