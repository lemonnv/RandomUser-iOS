//
//  DummyAuthenticator.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 12/02/2020.
//  Copyright © 2020 Vincent Lemonnier. All rights reserved.
//

public class DummyAuthenticator: AuthenticatorLogic {
    
    public init() {
        
    }
    
    public var isSignedIn: Bool { false }
    
    public func token() throws -> String? { nil }
    
    public func signUp() throws {}
    
    public func signIn() throws {}
    
    public func signOut() throws {}
    
    public func resetPassword(email: String) throws {}
    
}
