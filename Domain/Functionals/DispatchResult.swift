//
//  DispatchResult.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 11/02/2020.
//  Copyright © 2020 Vincent Lemonnier. All rights reserved.
//

import Foundation

public class DispatchResult<T> {
    
    private let semaphore = DispatchSemaphore(value: 0)
    
    public var value: T?
    public var error: Error?
    
    public init() {
        
    }
    
    public func release(value: T?, error: Error?) {
        self.value = value
        self.error = error
        self.semaphore.signal()
    }
    
    public func wait() throws -> T {
        if value == nil, error == nil {
            self.semaphore.wait()
        }
        guard error == nil else { throw error! }
        return value!
    }
    
}
