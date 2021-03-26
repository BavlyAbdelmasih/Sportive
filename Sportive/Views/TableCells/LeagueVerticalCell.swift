//
//  LeagueVerticalCell.swift
//  Sportive
//
//  Created by iambavly on 3/20/21.
//

import UIKit

class LeagueVerticalCell: UITableViewCell {

    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var leagueSport: UILabel!
    @IBOutlet weak var leagueName: UILabel!
    
    var youtubeImageClicked : (()->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func clickYoutube(_ sender: Any) {
        self.youtubeImageClicked!()
    }
    
}
