//
//  NetworkProtocol.swift
//  SmallCat
//
//  Created by Mai Nguyen on 11/9/20.
//  Copyright © 2020 Mai Nguyen. All rights reserved.
//

import Foundation
typealias  HTTPHeader = [String: String]


enum HTTPMethod: String {
    case put = "PUT"
    case get = "GET"
    case patch = "PATCH"
    case delete = "DELETE"
    case post = "POST"
    
    
}


protocol NetworkProtocol {
    var baseURL: String {get}
    var path: String {get}
    var httpHeader: HTTPHeader {get}
    var httpMethod: HTTPMethod {get}
    var request: URLRequest? {get}
    var parameters: [URLQueryItem]{get}
}
