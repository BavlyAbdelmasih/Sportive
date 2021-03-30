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
    var apiClient:ApiClient { get set }
    
}

class SportsViewsModel : SportsListViewProtcol {
    
    var apiClient: ApiClient
    var getSports: ((SportsListViewProtcol) -> (Void))?
    var sports : Sports?{
        didSet{
            getSports!(self)
        }
    }
    
    init( apiClient: ApiClient = ApiClient()) {
        self.apiClient = apiClient
    }
    
    func getApiData(isLoadingCompletion : @escaping (Bool)->Void){
        isLoadingCompletion(false)
        apiClient.getData(endPoint: "all_sports.php" , of: Sports.self) { [weak self] result in
            switch(result){
            case(.success(let data)):
                self?.sports = data as? Sports
            case(.failure(let error)):
                print("\(error)")
            }
            isLoadingCompletion(true)
            
        }
    }
    
    func leagueViewModelForSport(sport: Sport) -> LeaguesViewsModel {
        return LeaguesViewsModel(sport: sport)
    }
    
}
