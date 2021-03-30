//
//  LatestMatchesCell.swift
//  Sportive
//
//  Created by iambavly on 3/28/21.
//

import UIKit

class LatestMatchesCell: UICollectionViewCell {
    @IBOutlet weak var homeTeamName: UILabel!
    @IBOutlet weak var matchDate: UILabel!
    @IBOutlet weak var awayTeamName: UILabel!
    @IBOutlet weak var homeTeamLogo: UIButton!
    @IBOutlet weak var awayTeamLogo: UIButton!
    
    @IBOutlet weak var matchResult: UILabel!
    
    var didSelectAwayTeam : (() -> Void)?
    var didSelectHomeTeam : (() -> Void)?
    
    
    @IBAction func homeTeamClickListener(_ sender: Any) {
        self.didSelectHomeTeam!()
    }
    @IBAction func awayTeamSelectListner(_ sender: Any) {
        self.didSelectAwayTeam!()
    }
    
    
}
