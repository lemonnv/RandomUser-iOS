//
//  Result.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 11/02/2020.
//  Copyright © 2020 Vincent Lemonnier. All rights reserved.
//

public enum Result<T> {
    case canceled
    case success(T)
    case failure(Error)
    case newValue(T)
    case terminated(Error?)
    
    public var value: T? {
        switch self {
        case .success(let value):
            return value
        case .newValue(let value):
            return value
        default:
            return nil
        }
    }
    
    public var error: Error? {
        switch self {
        case .failure(let error):
            return error
        case .terminated(let error):
            return error
        default:
            return nil
        }
    }
}
