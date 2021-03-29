//
//  Team.swift
//  Sportive
//
//  Created by iambavly on 3/19/21.
//

import Foundation
struct Team : Decodable {
    let id : String
    let teamTitle : String?
    let sportTitle : String?
    let  leagueTitle : String?
    let teamDescription : String?
    let teamBackgroundImage : String?
    let teamLocation : String?
    let teamLogoImage : String
    let teamWebsite : String?
    let teamFacebook : String?
    let teamYoutube : String?
    let teamTwitter :String?
    let teamInstagram :String?
    let stadiumTitle : String?
    let stadiumImage : String?
    
    enum CodingKeys: String, CodingKey {
        case id  = "idTeam"
        case teamTitle = "strTeam"
        case sportTitle = "strSport"
        case  leagueTitle = "strLeague"
        case teamDescription = "strDescriptionEN"
        case teamBackgroundImage = "strTeamFanart1"
        case teamLocation = "strCountry"
        case teamLogoImage = "strTeamBadge"
        case teamWebsite = "strWebsite"
        case teamFacebook = "strFacebook"
        case teamYoutube = "strYoutube"
        case teamTwitter = "strTwitter"
        case teamInstagram = "strInstagram"
        case stadiumTitle = "strStadium"
        case stadiumImage = "strStadiumThumb"
    }
    
}


struct Teams: Decodable {
  var all: [Team]?
  
  enum CodingKeys: String, CodingKey {
    case all = "teams"
  }
}

