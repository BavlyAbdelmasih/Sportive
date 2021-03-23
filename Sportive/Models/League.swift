//
//  League.swift
//  Sportive
//
//  Created by iambavly on 3/19/21.
//

import Foundation

struct League : Decodable {
    let id : String
    let title : String
    let country : String
    let badge : String
    
    enum CodingKeys: String, CodingKey {
        case id = "idLeague"
        case title = "strLeague"
        case country = "strCountry"
        case  badge = "strBadge"
    }
    
}


struct Leagues: Decodable {
    let all: [League]
    
    enum CodingKeys: String, CodingKey {
        case all = "countrys"
    }
}
