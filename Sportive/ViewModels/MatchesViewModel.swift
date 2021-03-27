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
    var matches : Matches?{get set}
    var league : League?{ get set}
    init(league : League)
    
    
    
}

class MatchesViewModel : MatchesListViewProtocol {
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
    
}
    

