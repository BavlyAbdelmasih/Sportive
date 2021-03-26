//
//  LeguesViewsPresenter.swift
//  Sportive
//
//  Created by iambavly on 3/23/21.
//

import Foundation
protocol LeaguesListViewProtcol {
    func getAbstractApiData(isLoadingCompletion : @escaping (Bool)->Void)
    func getApiData(isLoadingCompletion : @escaping (Bool)->Void)
    var getLeagues : ((LeaguesListViewProtcol)->(Void))? { get }
    var leagues : Leagues? { get set }
    var leaguesHead : LeaguesHeader? {get set}
    var sport : Sport{ get set}
    init(sport:Sport)
    
}

class LeaguesViewsModel : LeaguesListViewProtcol {
    var sport: Sport
    
    
    required init(sport: Sport) {
        self.sport = sport
    }
    
    var leaguesHead: LeaguesHeader?
    var getLeagues: ((LeaguesListViewProtcol) -> (Void))?
    var resultArray : Leagues?{
        didSet{
            if(resultArray?.all.count == leaguesHead?.leagues.count){
                self.leagues = self.resultArray

            }
        }
    }
    
    var leagues : Leagues?{
        didSet{
            getLeagues!(self)
        }
    }
    
    
    private let apiClient = ApiClient()
    
    func getAbstractApiData(isLoadingCompletion : @escaping (Bool)->Void){
        isLoadingCompletion(true)
        resultArray = Leagues(all: [])
        apiClient.getData(endPoint: "all_leagues.php" , of: LeaguesHeader.self) { result in
            switch(result){
            case(.success(let data)):
                self.leaguesHead = data as? LeaguesHeader
                
            case(.failure(let error)):
                print("\(error)")
                
            }
            isLoadingCompletion(false)
            
        }
    }
    
    func getApiData(isLoadingCompletion : @escaping (Bool)->Void){
        
        self.getAbstractApiData(isLoadingCompletion: {isLoad in
            if(!isLoad){
                isLoadingCompletion(false)
                self.leaguesHead!.leagues = self.leaguesHead!.leagues.filter({$0.strSport == self.sport.title})
                for item in self.leaguesHead!.leagues {
                    self.apiClient.getData(endPoint: "lookupleague.php?id=\(item.idLeague)" , of: Leagues.self) { result in
                        switch(result){
                        case(.success(let data)):
                            self.resultArray?.all.append((data as! Leagues).all[0])

                            print(data)
                        case(.failure(let error)):
                            print("\(error)")
                            
                        }
                        
                    }
                    
                    
                }
                
//                isLoadingCompletion(true)

            }
        })
        
        
    }
    
}


struct LeagueHeader : Decodable {
    
    var idLeague : String
    var strSport : String
    
}

struct LeaguesHeader : Decodable {
    
    var leagues : [LeagueHeader]
    
}
