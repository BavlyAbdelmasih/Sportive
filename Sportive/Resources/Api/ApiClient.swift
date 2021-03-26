//
//  ApiClient.swift
//  Sportive
//
//  Created by iambavly on 3/23/21.
//

import Foundation
import Alamofire

class ApiClient {
    
    private var baseUrl = "https://www.thesportsdb.com/api/v1/json/1/"
    
    enum DataError : Error{
        
    }
    
    func getData <T : Decodable>(endPoint : String , of : T.Type , completion : @escaping (Result<Any , Error>)-> Void) {
        AF.request(baseUrl + endPoint)
          .validate()
          .responseDecodable(of: T.self) { (response) in
            guard let res = response.value , response.error == nil else {
                completion(.failure(response.error!))
                return
            }
            
            completion(.success(res))
          }
        
    }
    
}
