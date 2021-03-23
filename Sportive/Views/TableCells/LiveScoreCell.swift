//
//  LeugueDetailsTableViewCell.swift
//  Sportive
//
//  Created by Oufaa on 22/03/2021.
//

import UIKit

class LiveScoreCell: UITableViewCell {

    @IBOutlet weak var firstTeamImageView: UIImageView!
    @IBOutlet weak var secondTeamImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
