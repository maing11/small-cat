//
//  NetworkService.swift
//  SmallCat
//
//  Created by Mai Nguyen on 11/9/20.
//  Copyright © 2020 Mai Nguyen. All rights reserved.
//

import Foundation
import UIKit


typealias NetworkCompletion = (_ data: Data? , _ errorMessage: String?) -> Void

enum NetworkError: String {
    case badRequest
    case invalidURL
    case jsonDecoderError
    case reponseError
    case authError
    case genericError
    case outdatedError
    
}

enum Result {
    case success
    case failure(message: String)
}


class NetworkService{
    
    private var task: URLSessionDataTask?
    
    func request (client: NetworkProtocol, completion: @escaping  NetworkCompletion){
        let configuration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: configuration)
        
        
        guard let request = client.request  else {return}
        print(request.url!)
        
        task = urlSession.dataTask(with: request) {(data, response, error) in
            if error != nil {
                completion(nil,error!.localizedDescription)
            }
            guard let httpResponse = response as? HTTPURLResponse  else {
                completion(nil, NetworkError.reponseError.rawValue)
                return
            }
            
            let result = self.checkReponseResult(httpResponse: httpResponse)
            
            switch result {
            case .success: completion(data, nil)
            case .failure(let message): completion(nil, message)
            }
        }
        task?.resume()
    }
    private func checkReponseResult(httpResponse: HTTPURLResponse) -> Result {
        switch httpResponse.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(message: NetworkError.authError.rawValue)
        case 501...599: return .failure(message: NetworkError.badRequest.rawValue)
        case 600: return .failure(message: NetworkError.outdatedError.rawValue)
        
        default:
            return .failure(message: NetworkError.genericError.rawValue)
        }
    }
  
    func downloadData<T: Decodable>(client: NetworkProtocol,completion: @escaping ([T]) -> ()) {
        
        self.request(client: client) { (data, errorMessage) in
            if errorMessage == nil , data != nil {
                var objects = [T]()
                
                let jsonDecoder = JSONDecoder()
                do{
                    objects = try jsonDecoder.decode([T].self, from: data!)
                    completion(objects)
                    
                } catch {
                    print(NetworkError.jsonDecoderError.rawValue)
                }
            }
        }
    }
}

extension UIImageView {
    func downloadImage(urlString: String) {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, err) in
            if err == nil, let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
        
    }
}

