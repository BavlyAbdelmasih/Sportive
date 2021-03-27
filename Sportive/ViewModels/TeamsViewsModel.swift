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
    init(league : League)
    init(team : Team)

}

class TeamsViewsModel : TeamsListViewProtocol {
    var team: Team?
    required init(team: Team) {
        self.team = team
    }
    var league: League?
    
    required init(league: League) {
        self.league = league

    }
    
    
    func getDataFromApiServer(isLoadingCompletion: @escaping (Bool) -> Void) {
        isLoadingCompletion(false)
        ApiClient.instance.getData(endPoint: "lookup_all_teams.php?id=\((league?.id)!)", of: Teams.self, completion: {[weak self] result in
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
