//
//  SportsViewsPresenter.swift
//  Sportive
//
//  Created by iambavly on 3/23/21.
//

import Foundation

protocol SportsListViewProtcol {
    func getApiData(isLoadingCompletion : @escaping (Bool)->Void)
    var getSports : ((SportsListViewProtcol)->(Void))? { get }
    var sports : Sports? { get set }
    
}

class SportsViewsPresenter : SportsListViewProtcol {
    var getSports: ((SportsListViewProtcol) -> (Void))?

    var sports : Sports?{
        didSet{
            getSports!(self)
        }
    }
    
    
    private let apiClient = ApiClient()
    func getApiData(isLoadingCompletion : @escaping (Bool)->Void){
        isLoadingCompletion(false)
        apiClient.getData(urlStr: "https://www.thesportsdb.com/api/v1/json/1/all_sports.php" , of: Sports.self) { result in
            switch(result){
            case(.success(let data)):
                self.sports = data as? Sports
            case(.failure(let error)):
                print("\(error)")
                
            }
            isLoadingCompletion(true)

        }
        
    }
    
    
}
