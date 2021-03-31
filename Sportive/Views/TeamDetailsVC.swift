//
//  TeamDetailsVC.swift
//  Sportive
//
//  Created by iambavly on 3/19/21.
//

import UIKit
import JGProgressHUD

class TeamDetailsVC: UIViewController {
    
    @IBOutlet weak var teamTitleLabel: UILabel!
    @IBOutlet weak var leagueTitleLabel: UILabel!
    @IBOutlet weak var stadiumImage: UIImageView!
    @IBOutlet weak var teamDescriptionLabel: UILabel!
    @IBOutlet weak var teamLogoImage: UIImageView!
    @IBOutlet weak var teamCountryLabel: UILabel!
    @IBOutlet weak var screenBackgroundImage: UIImageView!
    @IBOutlet weak var stadiumTitleLabel: UILabel!
    @IBOutlet weak var stadiumBackgroundImage: UIImageView!

    var facebookUrl : String?
    var youtubeUrl : String?
    var twitterUrl : String?
    var webUrl : String?
    var viewMdel : TeamsViewsModel?
    let spinner = JGProgressHUD(style: .light)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stadiumImage.layer.cornerRadius = 20
        stadiumImage.clipsToBounds = true
        let item = self.viewMdel!.team
        self.teamTitleLabel.text = item?.teamTitle
        self.leagueTitleLabel.text = item?.leagueTitle
        self.teamLogoImage.sd_setImage(with: URL(string: item!.teamLogoImage), placeholderImage: UIImage(named: "placeholder.png"))
        self.teamDescriptionLabel.text = item?.teamDescription
        self.screenBackgroundImage.sd_setImage(with: URL(string: item!.teamBackgroundImage ?? "placeholder.png"), placeholderImage: UIImage(named: "placeholder.png"))
        self.teamCountryLabel.text = item?.teamLocation
        self.stadiumImage.sd_setImage(with: URL(string: item!.stadiumImage ?? "placeholder.png"), placeholderImage: UIImage(named: "placeholder.png"))
        self.stadiumTitleLabel.text = item?.stadiumTitle
        
        self.facebookUrl = item?.teamFacebook
        self.twitterUrl = item?.teamTwitter
        self.webUrl = item?.teamWebsite
        self.youtubeUrl = item?.teamYoutube
        
    }
    
    @IBAction func openFacebookPage(_ sender: Any) {
        
        if let url = URL(string: "https://\(facebookUrl!)") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func openYoutubePage(_ sender: Any) {
        if let url = URL(string: "https://\(youtubeUrl!)") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func openTwitterPage(_ sender: Any) {
        if let url = URL(string: "https://\(twitterUrl!)") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func openTeamWebsite(_ sender: Any) {
        if let url = URL(string: "https://\(webUrl!)") {
            UIApplication.shared.open(url)
        }
    }
    
}

