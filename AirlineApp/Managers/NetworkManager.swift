//
//  NetworkManager.swift
//  GitHubAPI
//
//  Created by mohamed fawzy on 19September//2021.
//

import UIKit.UIImage

class NetworkManager{
    static let shared = NetworkManager()
    private init(){}
    
    private let cache = NSCache<NSString,UIImage>()
    private let baseURL = "https://api.instantwebtools.net/v1/airlines"
    
    func getAirlines(completionHandler: @escaping (Result<[Airline], AirlineApiError>)->Void) {
        guard let url = URL(string: baseURL) else {
            completionHandler(.failure(.invalidRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = self.errorExists(error: error, response: response, data: data) {
                completionHandler(.failure(error))
            }else{
                do{
                    let decoder = JSONDecoder()
                    let airlines = try decoder.decode([Airline].self, from: data!)
                    completionHandler(.success(airlines))
                }
                catch{
                    completionHandler(.failure(.invalidData))
                }
            }
        }
        
        task.resume()
    }
    

    func addAirline(airline: Airline, completionHandler: @escaping (AirlineApiError?) -> Void) {
        guard let url = URL(string: baseURL) else {
            completionHandler(.invalidRequest)
            return
        }
        var request: URLRequest
        do{
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(airline)
            request = createPostRequest(fromUrl: url, withData: jsonData)
        }
        catch {
            completionHandler(.invalidData)
            return
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = self.errorExists(error: error, response: response, data: data) {
                completionHandler(error)
            }else{
                completionHandler(nil)
            }
        }
        task.resume()
    }
    
    func createPostRequest(fromUrl url:URL, withData data: Data)-> URLRequest{
        // To ensure that our request is always sent, we tell
        // the system to ignore all local cache data:
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        return request
    }
    
    func downloadImage(from urlString:String, completionHandler: @escaping (UIImage)->Void){
        guard let url = URL(string: urlString) else {return}
        
        if let image = cache.object(forKey: urlString as NSString) {
            completionHandler(image)
        }else{
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {return}
                
                guard let response = response as? HTTPURLResponse,
                      response.statusCode == 200 else {return}
                
                guard let data = data,
                      let image = UIImage(data: data) else {return}
                
                self.cache.setObject(image, forKey: urlString as NSString)
                completionHandler(image)
            }
            task.resume()
        }
    }
}

//MARK:- Error Handeling
extension NetworkManager {
    private func errorExists(error:Error?, response: URLResponse?, data:Data?)-> AirlineApiError?{
        if  let error = error{
            let mappedError = transportErrorMapping(error: error)
            return mappedError
        }
        
        if let response = response as? HTTPURLResponse,
              !(200..<300).contains(response.statusCode) {
            let mappedError = self.httpResponseErrorMapping(errorCode: response.statusCode)
            return mappedError
        }
        
        if data == nil{
            return .invalidData
        }
        return nil
    }
    
    private func transportErrorMapping(error: Error) -> AirlineApiError{
        switch error {
            case let error as NSError where error.code == NSURLErrorNotConnectedToInternet:
                return .noInternetConnection
            case let error:
                print(error)
                return .unknownError
            }
    }
    private func httpResponseErrorMapping(errorCode:Int)->AirlineApiError{
        switch(errorCode){
        case 400..<500:
            return .invalidRequest
        case 500..<600:
            return .serverError
        default:
            return .unknownError
        }
    }
}














