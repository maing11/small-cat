//
//  CatClient.swift
//  SmallCat
//
//  Created by Mai Nguyen on 11/9/20.
//  Copyright © 2020 Mai Nguyen. All rights reserved.
//

import Foundation
 let apiKey = "ea800517-73a9-4f03-8d75-0ac663eab1cf"

enum CatClient {
    case search
}

extension CatClient: NetworkProtocol {
    var baseURL: String {
        return "https://api.thecatapi.com"
    }
    
    var path: String {
        return "/v1/images/search"
    }
    
       var httpHeader: HTTPHeader {
        return ["apiKey": apiKey,
                "content Type": "application/json"]
       }
       
      
    var httpMethod: HTTPMethod {
        .get
    }
    
    var request: URLRequest? {
       var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = path
        urlComponents?.queryItems = parameters
        
        if let url = urlComponents?.url {
            var request = URLRequest(url: url)
            request.httpMethod = httpMethod.rawValue
            request.allHTTPHeaderFields = httpHeader
            return request
        }
        return nil
    }
    
    var parameters: [URLQueryItem] {
        return [URLQueryItem(name: "limit", value: "20")]
    }
 
}
