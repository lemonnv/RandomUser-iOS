//
//  Empty.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 12/02/2020.
//  Copyright © 2020 Vincent Lemonnier. All rights reserved.
//

enum Empty: Codable {
    
    init(from decoder: Decoder) throws {
        fatalError("unimplemented")
    }
    
    func encode(to encoder: Encoder) throws {
        fatalError("unimplemented")
    }
}
