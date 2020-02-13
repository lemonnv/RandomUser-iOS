//
//  API+Request.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 11/02/2020.
//  Copyright © 2020 Vincent Lemonnier. All rights reserved.
//

import Foundation

extension API {
    
    struct Request<Model: API.Model> {
        
        let method: HTTPMethod
        let url: URL
        var headers: [String : String]
        let query: Model.Params?
        let body: Model.Request?
        
        
        //MARK: Object lifecycle
        
        init(method: HTTPMethod, baseURL: String, domain: Domain, action: Action?, pathParams: [String] = [], query: Model.Params? = nil, body: Model.Request? = nil) {
            self.method = method
            var urlComponents = URLComponents(baseUrl: baseURL, domain: domain, action: action, pathParams: pathParams)!
            urlComponents.queryItems = query?.dictionary?.map({
                if let value = $0.value as? String {
                    return URLQueryItem(name: $0.key, value: value)
                } else {
                    return URLQueryItem(name: $0.key, value: $0.value.string)
                }
            })
            self.url = urlComponents.url!
            self.headers = [
                Header.contentType: "application/json; charset=utf-8"
            ]
            self.query = query
            self.body = body
        }
        
        
        //MARK: Properties
        
        var urlRequest: URLRequest {
            var request = URLRequest(url: self.url)
            request.httpMethod = self.method.rawValue
            request.httpBody = self.body?.json
            request.allHTTPHeaderFields = self.headers
            return request
        }
        
        var requestName: String {
            return url.absoluteString.replacingOccurrences(of: baseURL, with: "")
        }
    }
}

fileprivate extension URLComponents {
    
    init?(baseUrl: String, domain: API.Domain, action: API.Action?, pathParams: [String] = []) {
        var urlString = "\(baseUrl)/\(domain.rawValue)"
        if let action = action {
            urlString += "/\(action.rawValue)"
        }
        for param in pathParams {
            urlString += "/\(param)"
        }
        self.init(string: urlString)
    }
    
}

fileprivate extension Encodable {
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    var dictionary: [String: AnyObject]? {
        guard let data = self.json else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: AnyObject] }
    }
}

