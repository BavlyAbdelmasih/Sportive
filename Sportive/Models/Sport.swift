//
//  Sport.swift
//  Sportive
//
//  Created by iambavly on 3/19/21.
//

import Foundation
struct Sport : Decodable {
    let id : String
    let title : String
    let type : String
    let  backgroundImageUrl : String
    let description : String
    
    enum CodingKeys: String, CodingKey {
        case id = "idSport"
        case title = "strSport"
        case type = "strFormat"
        case  backgroundImageUrl = "strSportThumb"
        case description = "strSportDescription"
    }
    
}


struct Sports: Decodable {
  let all: [Sport]
  
  enum CodingKeys: String, CodingKey {
    case all = "sports"
  }
}
