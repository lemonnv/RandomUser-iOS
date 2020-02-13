//
//  API+Response.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 11/02/2020.
//  Copyright © 2020 Vincent Lemonnier. All rights reserved.
//

import Foundation

extension API {
    
    struct Response<Model: API.Model> {
        
        var statusCode: HTTPStatusCode
        var body: Model.Response?
        var error: Error?
        
        
        //MARK: Object lifecycle
        
        init(statusCode: HTTPStatusCode, body: Model.Response?, error: Error?) {
            self.statusCode = statusCode
            self.body = body
            self.error = error
        }
        
        init(data: Data?, urlResponse: HTTPURLResponse, error: Error?) {
            self.statusCode = HTTPStatusCode(rawValue: urlResponse.statusCode)!
            self.body = data?.decode()
        }
        
        func accept(_ codes: HTTPStatusCode ...) throws -> Response<Model> {
            if let error = self.error {
                throw error
            }
            
            switch self.statusCode {
            case _ where codes.contains(self.statusCode):
                return self
            default:
                throw NSError(domain: "statusCode", code: self.statusCode.rawValue, userInfo: nil)
            }
        }
    }
}


fileprivate extension Data {
    
    func decode<T: Decodable>() -> T? {
        var result: T?
        do {
            result = try JSONDecoder().decode(T.self, from: self)
        } catch {
            print(error)
        }
        return result
    }
}
