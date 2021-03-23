//
//  Sports.swift
//  Sportive
//
//  Created by iambavly on 3/23/21.
//

import Foundation
struct Sports: Decodable {
  let all: [Sport]
  
  enum CodingKeys: String, CodingKey {
    case all = "sports"
  }
}
