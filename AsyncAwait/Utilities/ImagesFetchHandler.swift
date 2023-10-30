//
//  ImagesFetchHandler.swift
//  Learning-Examples
//
//  Created by Karthi Rasu on 23/07/23.
//

import UIKit

enum Webservices : String {
    case photos = "https://api.unsplash.com/photos"
}

class ImagesFetchHandler {
    
    static let shared = ImagesFetchHandler()
    
    let photosUrl = "https://api.unsplash.com/photos"
    
    private init(){}
    
    func fetchImage(imageURL:String) async throws -> UIImage?{
        guard let imageURL = URL(string: imageURL) else { return nil}
        let request = URLRequest(url: imageURL)
        let (data,_) = try await URLSession.shared.data(for: request)
        return UIImage(data: data)
    }
    
    func unsplashPhotosFetch<T:Codable>(page:Int,type:T.Type) async throws -> T{
        guard var url = URL(string: photosUrl) else {
            throw NetworkingError.invalidUrl
        }
        url.appendQueryItem(name: "client_id", value: "Txt97o2IO-1fSGPPQ55G7ddbCQdxoFSImoJdKeoP5Mc")
        url.appendQueryItem(name: "page", value: "\(page)")
        url.appendQueryItem(name: "per_page", value: "10")
        url.appendQueryItem(name: "order_by", value: "latest")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data,response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
            throw NetworkingError.invalidStatusCode
        }
        
        do{
            let decoder = JSONDecoder()
            let decodedResult = try decoder.decode(T.self, from: data)
            return decodedResult
        }catch{
            throw NetworkingError.failedToDecode(error: error)
        }
    }
    
    
    func fetchAPICallsWithGeneric<T:Decodable>(url:Webservices,
                                               type:T.Type,
                                             completion:@escaping (Result<T,NetworkingError>)->Void){
        guard var url = URL(string: url.rawValue) else {
            completion(.failure(.invalidUrl))
            return
        }
        url.appendQueryItem(name: "client_id", value: "Txt97o2IO-1fSGPPQ55G7ddbCQdxoFSImoJdKeoP5Mc")
        url.appendQueryItem(name: "page", value: "1")
        url.appendQueryItem(name: "per_page", value: "10")
        url.appendQueryItem(name: "order_by", value: "latest")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil{
                completion(.failure(.custom(error: error!)))
                return
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completion(.failure(.invalidStatusCode))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let decodedResult = try decoder.decode(T.self, from: data)
                completion(.success(decodedResult))
            }catch{
                completion(.failure(.failedToDecode(error: error)))
            }
        }
        
        dataTask.resume()
    }
}

enum NetworkingError : Error {
    case invalidUrl
    case custom(error:Error)
    case invalidStatusCode
    case invalidData
    case failedToDecode(error:Error)
}
