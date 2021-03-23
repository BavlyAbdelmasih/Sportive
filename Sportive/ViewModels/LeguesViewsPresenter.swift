//
//  LeguesViewsPresenter.swift
//  Sportive
//
//  Created by iambavly on 3/23/21.
//

import Foundation
protocol LeaguesListViewProtcol {
    func getApiData(sportTitle:String ,isLoadingCompletion : @escaping (Bool)->Void)
    var getLeagues : ((LeaguesListViewProtcol)->(Void))? { get }
    var leagues : Leagues? { get set }
    
}

class LeaguesViewsPresenter : LeaguesListViewProtcol {
    
    var sports: Sports?
    
    var getLeagues: ((LeaguesListViewProtcol) -> (Void))?

    var leagues : Leagues?{
        didSet{
            getLeagues!(self)
        }
    }
    
    
    private let apiClient = ApiClient()
    func getApiData(sportTitle:String,isLoadingCompletion : @escaping (Bool)->Void){
        isLoadingCompletion(false)
        apiClient.getData(urlStr: "https://www.thesportsdb.com/api/v1/json/1/search_all_leagues.php?s=\(sportTitle)" , of: Leagues.self) { result in
            switch(result){
            case(.success(let data)):
                self.leagues = data as? Leagues
            case(.failure(let error)):
                print("\(error)")
                
            }
            isLoadingCompletion(true)

        }
        
    }
    
    
}
