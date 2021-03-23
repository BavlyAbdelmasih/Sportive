//
//  ApiClient.swift
//  Sportive
//
//  Created by iambavly on 3/23/21.
//

import Foundation
import Alamofire

class ApiClient {
    
    enum DataError : Error{
        
    }
    
    func getData <T : Decodable>(urlStr : String , of : T.Type , completion : @escaping (Result<Any , Error>)-> Void) {
        AF.request(urlStr)
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
