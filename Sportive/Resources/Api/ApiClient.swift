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

class MockupApiClient: ApiClient {
    enum MockUpError : Error {
        case errorGettingUrlStub
    }
    override func getData<T>(endPoint: String, of: T.Type, completion: @escaping (Result<Any, Error>) -> Void) where T : Decodable {
        guard let urlStub = Bundle.main.url(forResource: endPoint, withExtension: "json") else{
            completion(.failure(MockUpError.errorGettingUrlStub))
            return
        }
        
        AF.request(urlStub)
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
