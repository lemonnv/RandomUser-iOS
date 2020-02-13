//
//  EntityMappable.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 13/02/2020.
//  Copyright © 2020 Vincent Lemonnier. All rights reserved.
//

open class EntityMappable<A, B> {
    
    public init() {
        
    }
    
    open func from(entity: B) -> A {
        fatalError("must be overrided")
    }
    
    open func to(entity type: A) -> B {
        fatalError("must be overrided")
    }
}

