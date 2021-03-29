//
//  MatchesViewPresenter.swift
//  Sportive
//
//  Created by iambavly on 3/26/21.
//

import Foundation

protocol MatchesListViewProtocol {
    func getDataFromApiServer(isLoadingCompletion :@escaping (Bool)->Void )
    var getData : ((MatchesListViewProtocol)->Void)?{ get set}
    func getTwoTeamsForMatches(teams : Teams , isLoadingCompletion :@escaping (Bool)->Void )
    var matches : Matches?{get set}
    var league : League?{ get set}
    var twoTeams : [[Team]]? { get set }
    init(league : League)
    
    
    
}

class MatchesViewModel : MatchesListViewProtocol {
    var twoTeams: [[Team]]?
    
    var getData: ((MatchesListViewProtocol) -> Void)?
    
    
    var league: League?
    
    required init(league : League) {
        self.league = league
    }
    
    var matches: Matches?{
        didSet{
            self.getData!(self)
        }
    }
    
    
    func getDataFromApiServer(isLoadingCompletion: @escaping (Bool) -> Void) {
        isLoadingCompletion(false)
        ApiClient.instance.getData(endPoint: "eventspastleague.php?id=\((league?.id)!)", of: Matches.self, completion: { [weak self] result in
            switch(result){
            case(.failure(let error)):
                print("\(error)")
            case (.success(let data)):
                self?.matches = data as? Matches
            }
            
            isLoadingCompletion(true)
            
        })
    }
    
    func getTwoTeamsForMatches(teams : Teams , isLoadingCompletion :@escaping (Bool)->Void ){
        twoTeams = []
        isLoadingCompletion(false)
        
        guard let matchArray = matches?.all else{ return}
        
        
        for item in matchArray {
            guard let homeTeamId = item.homeTeamId , let awayTeamId = item.awayTeamId   else {
                return
            }
            
            guard let homeTeam = teams.all?.filter({$0.id == homeTeamId
            })[0] else{
                return
            }
            
            guard let awayTeam = teams.all?.filter({$0.id == awayTeamId
            })[0] else{
                return
            }
            
            twoTeams?.append([homeTeam , awayTeam])
        }
        isLoadingCompletion(true)
    }
    
}
    

