//
//  WebServicesHandler.swift
//  Learning-Examples
//
//  Created by Karthi Rasu on 31/07/23.
//

import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private var afSession : Session = AF
    
    private init(){
        
    }
    
    private func getHeaders()->HTTPHeaders{
        return HTTPHeaders(["":""])
    }
    
    func makePostAPICall<T:Codable>(type:T.Type,parameters:[String:Any],completion:@escaping (_ data:T?,_ error:NetworkingError?)->Void){
        
        guard var url = URL(string: Webservices.photos.rawValue) else {
            completion(nil, .invalidUrl)
            return
        }
        
        url.appendQueryItem(name: "client_id", value: "Txt97o2IO-1fSGPPQ55G7ddbCQdxoFSImoJdKeoP5Mc")
        
        afSession.request(url,method: .get,parameters: nil,headers: nil)
            .validate()
            .responseData { responseData in
            if responseData.error != nil{
                completion(nil, .invalidData)
            }
            
            guard let statusCode = responseData.response?.statusCode , statusCode == 200 else {
                completion(nil, .invalidStatusCode)
                return
            }
            
            guard let data = responseData.data else {
                completion(nil, .invalidData)
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let decodedResult = try decoder.decode(T.self, from: data)
                dump(decodedResult)
                completion(decodedResult, nil)
            }catch{
                completion(nil, .failedToDecode(error: error))
            }
        }
    }
}
