//
//  League.swift
//  Sportive
//
//  Created by iambavly on 3/19/21.
//

import Foundation

struct League : Decodable {
    var id : String?
    var title : String?
    var country : String?
    var badge : String?
    var leagueYoutube : String?
//    var banner : String
    
    enum CodingKeys: String, CodingKey {
        case id = "idLeague"
        case title = "strLeague"
        case country = "strCountry"
        case  badge = "strBadge"
        case leagueYoutube = "strYoutube"
//        case banner = "strBanner"
    }
    
}


struct Leagues: Decodable {
    var all: [League]
    
    enum CodingKeys: String, CodingKey {
        case all = "leagues"
    }
}

