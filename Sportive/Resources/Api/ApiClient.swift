//
//  ApiClient.swift
//  Sportive
//
//  Created by iambavly on 3/23/21.
//

import Foundation
import Alamofire

class ApiClient {
    
    public static let instance = ApiClient()
    private init() {}
    
    private var baseUrl = "https://www.thesportsdb.com/api/v1/json/1/"
    
    public func getData <T : Decodable>(endPoint : String , of : T.Type , completion : @escaping (Result<Any , Error>)-> Void) {
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
