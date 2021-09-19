//
//  NetworkManager.swift
//  GitHubAPI
//
//  Created by mohamed fawzy on 19September//2021.
//

import UIKit

class NetworkManager{
    static let shared = NetworkManager()
    private init(){}
    
    let cache = NSCache<NSString,UIImage>()
    let baseURL = "https://api.instantwebtools.net/v1/airlines"
    
    func getAirlines(completionHandler: @escaping (Result<[Airline], AirlineApiError>)->Void) {
                
        guard let url = URL(string: baseURL) else {
            completionHandler(.failure(.invalidRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completionHandler(.failure(.invalidRequest))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
                    completionHandler(.failure(.serverError))
                    return
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let airlines = try decoder.decode([Airline].self, from: data)
                completionHandler(.success(airlines))
            }
            catch {
                completionHandler(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    
    func downloadImage(from urlString:String, completionHandler: @escaping (UIImage)->Void){
        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {return}
            
            guard let response = response as? HTTPURLResponse,
                      response.statusCode == 200 else {return}
            
            guard let data = data,
                  let image = UIImage(data: data) else {return}
            
            completionHandler(image)
        }
        task.resume()
    }
    

}






















// old way with out result type
//    func getFollowers(for username: String,
//                      page: Int,
//                      completionHandler: @escaping ([Follower]?, GHError?)->Void) {
//
//        let endPoint = baseURL + "/users/\(username)/followers?per_page=100&page=\(page)"
//
//        guard let url = URL(string: endPoint) else {
//            completionHandler(nil, GHError.invalidUsername)
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard error == nil else {
//                completionHandler(nil, GHError.unableToComplete)
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse,
//                response.statusCode == 200 else {
//                    completionHandler(nil, GHError.invalidResponse)
//                    return
//            }
//
//            guard let data = data else {
//                completionHandler(nil, GHError.invalidData)
//                return
//
//            }
//
//            do{
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let followers = try decoder.decode([Follower].self, from: data)
//                completionHandler(followers, nil)
//            }
//            catch {
//                completionHandler(nil, GHError.invalidData)
//            }
//        }
//
//        task.resume()
//    }
//}

