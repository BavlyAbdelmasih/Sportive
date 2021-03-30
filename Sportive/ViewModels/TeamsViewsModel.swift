//
//  TeamsViewsPresenter.swift
//  Sportive
//
//  Created by iambavly on 3/24/21.
//

import Foundation

protocol TeamsListViewProtocol {
    func getDataFromApiServer(isLoadingCompletion :@escaping (Bool)->Void )
    var getData : ((TeamsListViewProtocol)->Void)?{ get set}
    var teams : Teams?{get set}
    var team : Team?{get set}

    var league : League?{ get set}
    var apiClient : ApiClient { get set }
    init(league : League , apiClient : ApiClient)
    init(team : Team , apiClient : ApiClient)
    init(apiClient : ApiClient)

}

class TeamsViewsModel : TeamsListViewProtocol {
   
    var team: Team?
    var apiClient: ApiClient
    required init(team: Team , apiClient: ApiClient = ApiClient()) {
        self.team = team
        self.apiClient = apiClient
        
    }
    var league: League?
    
    required init(league: League , apiClient: ApiClient = ApiClient()) {
        self.league = league
        self.apiClient = apiClient
    }
    required init(apiClient: ApiClient = ApiClient()) {
        self.apiClient = apiClient
    }
    
    
    
    func getDataFromApiServer(isLoadingCompletion: @escaping (Bool) -> Void) {
        isLoadingCompletion(false)
        apiClient.getData(endPoint: "lookup_all_teams.php?id=\((league?.id)!)", of: Teams.self, completion: {[weak self] result in
            switch(result){
            case(.failure(let error)):
                print("\(error)")
            case (.success(let data)):
                self?.teams = data as? Teams
            }
            isLoadingCompletion(true)
            
        })
    }
    
    var getData: ((TeamsListViewProtocol) -> Void)?
    
    var teams: Teams?{
        didSet{
            getData!(self)
        }
    }
    
    func TeamsViewModelForTeam(team : Team)-> TeamsViewsModel{
        return TeamsViewsModel(team: team)
    }
    
    
}
