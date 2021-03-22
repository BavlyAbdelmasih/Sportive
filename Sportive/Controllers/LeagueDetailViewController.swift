//
//  LeagueDetailViewController.swift
//  Sportive
//
//  Created by Oufaa on 21/03/2021.
//

import UIKit

class LeagueDetailViewController: UIViewController {
    
    @IBOutlet weak var eventsToolBar: UIToolbar!
    @IBOutlet weak var detailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailTableView.delegate = self
        detailTableView.dataSource = self

    }
    
    
}

extension LeagueDetailViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            if let cell = self.detailTableView.dequeueReusableCell(withIdentifier: "LeugueDetailsTableViewCell") as? LeugueDetailsTableViewCell {
                
                cell.firstTeamImageView?.image = UIImage(named: "premierLeague.jpg")
                cell.secondTeamImageView?.image = UIImage(named: "premierLeague.jpg")
                return cell
            }
            
            return UITableViewCell()
        
    
    
    
}
}
