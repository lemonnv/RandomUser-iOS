//
//  API.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 11/02/2020.
//  Copyright © 2020 Vincent Lemonnier. All rights reserved.
//

protocol ModelProtocol {
    associatedtype Params: Encodable
    associatedtype Request: Encodable
    associatedtype Response: Decodable
}

public struct API {
    
    typealias Model = ModelProtocol
    
    public static let baseURL: String = "https://randomuser.me/api"
    
    public enum Domain: String {
        case user = ""
    }
    
    public enum Action: String {
        case results = "results"
    }
    
    public struct Header {
        public static let authorization = "Authorization"
        public static let contentType = "Content-Type"
    }
    
    public enum HTTPMethod: String {
        case get     = "GET"
        case head    = "HEAD"
        case post    = "POST"
        case put     = "PUT"
        case patch   = "PATCH"
        case delete  = "DELETE"
    }
    
    public enum HTTPStatusCode: Int {
        case unknown = -1
        // 100 Informational
        case continueStatus = 100
        case switchingProtocols
        case processing
        // 200 Success
        case ok = 200
        case created
        case accepted
        case nonAuthoritativeInformation
        case noContent
        case resetContent
        case partialContent
        case multiStatus
        case alreadyReported
        case iMUsed = 226
        // 300 Redirection
        case multipleChoices = 300
        case movedPermanently
        case found
        case seeOther
        case notModified
        case useProxy
        case switchProxy
        case temporaryRedirect
        case permanentRedirect
        // 400 Client Error
        case badRequest = 400
        case unauthorized
        case paymentRequired
        case forbidden
        case notFound
        case methodNotAllowed
        case notAcceptable
        case proxyAuthenticationRequired
        case requestTimeout
        case conflict
        case gone
        case lengthRequired
        case preconditionFailed
        case payloadTooLarge
        case uriTooLong
        case unsupportedMediaType
        case rangeNotSatisfiable
        case expectationFailed
        case imATeapot
        case misdirectedRequest = 421
        case unprocessableEntity
        case locked
        case failedDependency
        case upgradeRequired = 426
        case preconditionRequired = 428
        case tooManyRequests
        case requestHeaderFieldsTooLarge = 431
        case unavailableForLegalReasons = 451
        // 500 Server Error
        case internalServerError = 500
        case notImplemented
        case badGateway
        case serviceUnavailable
        case gatewayTimeout
        case httpVersionNotSupported
        case variantAlsoNegotiates
        case insufficientStorage
        case loopDetected
        case notExtended = 510
        case networkAuthenticationRequired
        
        public var isSuccess: Bool {
            return self == .ok || self == .accepted || self == .created || self == .nonAuthoritativeInformation || self == .noContent || self == .resetContent || self == .partialContent || self == .multiStatus || self == .alreadyReported || self == .iMUsed
        }
    }
    
}

