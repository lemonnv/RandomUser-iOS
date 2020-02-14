//
//  APIClient.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 11/02/2020.
//  Copyright © 2020 Vincent Lemonnier. All rights reserved.
//

import Foundation

class APIClient {
    
    typealias RequestAuthTokenHandler = () throws -> String
    
    private let authenticator: AuthenticatorLogic
    private let session: URLSession
    
    
    //MARK: Object lifecycle
    
    init(authenticator: AuthenticatorLogic) {
        self.authenticator = authenticator
        self.session = URLSession.shared
    }
    
    
    //MARK: Request management
    
    func request<T: API.Model>(_ request: API.Request<T>, authenticated: Bool = false) throws -> API.Response<T> {
        var request = request
        
        if authenticated {
            if let token = try authenticator.token() {
                request.headers[API.Header.authorization] = "Bearer \(token)"
            }
        }
        
        var response: API.Response<T>!
        let semaphore = DispatchSemaphore(value: 0)
        
        let task = self.session.dataTask(with: request.urlRequest) { data, urlResponse, error in
            if let urlResponse = urlResponse as? HTTPURLResponse {
                response = API.Response<T>(data: data, urlResponse: urlResponse, error: error)
            } else {
                response = API.Response<T>(statusCode: .unknown, body: nil, error: error)
            }
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
        
        if !response.statusCode.isSuccess {
            print("API: \(request.method.rawValue) \(request.requestName) -> \(response.statusCode.rawValue)")
        } else {
            print("API: \(request.method.rawValue) \(request.url) -> \(response.statusCode.rawValue)")
        }
        return response
    }
    
    func get<T: API.Model>(baseURL: String = API.baseURL, domain: API.Domain, action: API.Action?, pathParams: [String] = [], query: T.Params? = nil, authenticated: Bool = false) throws -> API.Response<T> {
        return try request(API.Request(method: .get, baseURL: baseURL, domain: domain, action: action, pathParams: pathParams, query: query), authenticated: authenticated)
    }
    
    func post<T: API.Model>(baseURL: String = API.baseURL, domain: API.Domain, action: API.Action?, pathParams: [String] = [], body: T.Request? = nil, authenticated: Bool = false) throws -> API.Response<T> {
        return try request(API.Request(method: .post, baseURL: baseURL, domain: domain, action: action, pathParams: pathParams, body: body), authenticated: authenticated)
    }
    
    func put<T: API.Model>(baseURL: String = API.baseURL, domain: API.Domain, action: API.Action?, pathParams: [String] = [], body: T.Request? = nil, authenticated: Bool = false) throws -> API.Response<T> {
        return try request(API.Request(method: .put, baseURL: baseURL, domain: domain, action: action, pathParams: pathParams, body: body), authenticated: authenticated)
    }
    
    func patch<T: API.Model>(baseURL: String = API.baseURL, domain: API.Domain, action: API.Action?, pathParams: [String] = [], body: T.Request? = nil, authenticated: Bool = false) throws -> API.Response<T> {
        return try request(API.Request(method: .patch, baseURL: baseURL, domain: domain, action: action, pathParams: pathParams, body: body), authenticated: authenticated)
    }
    
    func delete<T: API.Model>(baseURL: String = API.baseURL, domain: API.Domain, action: API.Action?, pathParams: [String] = [], body: T.Request? = nil, authenticated: Bool = false) throws -> API.Response<T> {
        return try request(API.Request(method: .delete, baseURL: baseURL, domain: domain, action: action, pathParams: pathParams, body: body), authenticated: authenticated)
    }
}
