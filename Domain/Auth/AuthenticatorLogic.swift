//
//  AuthenticatorLogic.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 12/02/2020.
//  Copyright © 2020 Vincent Lemonnier. All rights reserved.
//

public protocol AuthenticatorLogic {
    var isSignedIn: Bool { get }
    func token() throws -> String?
    func signUp() throws
    func signIn() throws
    func signOut() throws
    func resetPassword(email: String) throws
    
}
