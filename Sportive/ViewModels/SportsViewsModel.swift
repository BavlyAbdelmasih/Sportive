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

class SportsViewsModel : SportsListViewProtcol {
    func leagueViewModelForSport(sport: Sport) -> LeaguesViewsModel {
        return LeaguesViewsModel(sport: sport)
    }
    

    var getSports: ((SportsListViewProtcol) -> (Void))?

    var sports : Sports?{
        didSet{
            getSports!(self)
        }
    }
    
    private let apiClient = ApiClient()
    func getApiData(isLoadingCompletion : @escaping (Bool)->Void){
        isLoadingCompletion(false)
        apiClient.getData(endPoint: "all_sports.php" , of: Sports.self) { result in
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
