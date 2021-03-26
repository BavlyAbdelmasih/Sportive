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
}

class TeamsViewsModel : TeamsListViewProtocol {
    
    private let apiClient = ApiClient()
    func getDataFromApiServer(isLoadingCompletion: @escaping (Bool) -> Void) {
        isLoadingCompletion(false)
        apiClient.getData(endPoint: "lookupteam.php?id=133616", of: Teams.self, completion: {result in
            switch(result){
            case(.failure(let error)):
                print("\(error)")
            case (.success(let data)):
                self.teams = data as? Teams
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
    
    
}
