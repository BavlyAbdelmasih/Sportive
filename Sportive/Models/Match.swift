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
    let homeTeamScore : String?
    let awayTeamScore : String?
    let stadiumTitle : String?
    let country : String?
    let dateEvent : String?
    
    
    enum CodingKeys: String, CodingKey {
        case id  = "idEvent"
        case matchTitle = "strEvent"
        case sportTitle = "strSport"
        case  leagueTitle = "strLeague"
        case homeTeamId = "idHomeTeam"
        case awayTeamId = "idAwayTeam"
        case homeTeamScore = "intHomeScore"
        case awayTeamScore = "intAwayScore"
        case stadiumTitle = "strVenue"
        case country = "strCountry"
        case dateEvent = "dateEvent"
        
    }
    
}


struct Matches: Decodable {
    var all: [Match]?
    
    enum CodingKeys: String, CodingKey {
        case all = "events"
    }
}

