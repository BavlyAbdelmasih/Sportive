//
//  Match.swift
//  Sportive
//
//  Created by iambavly on 3/26/21.
//

import Foundation

struct Match : Decodable{
    let id : String?
    let matchTitle : String?
    let sportTitle : String?
    let  leagueTitle : String?
    let homeTeamId : String?
    let awayTeamId : String?
//    let stadiumTitle : String?
//    let country : String?
//    let result : String?
    
    
    enum CodingKeys: String, CodingKey {
        case id  = "idEvent"
        case matchTitle = "strEvent"
        case sportTitle = "strSport"
        case  leagueTitle = "strLeague"
        case homeTeamId = "idHomeTeam"
        case awayTeamId = "idAwayTeam"

    }
    
}


struct Matches: Decodable {
  let all: [Team]
  
  enum CodingKeys: String, CodingKey {
    case all = "events"
  }
}

