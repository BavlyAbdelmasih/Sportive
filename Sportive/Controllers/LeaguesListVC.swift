//
//  LeaguesListVC.swift
//  Sportive
//
//  Created by iambavly on 3/19/21.
//

import UIKit

class LeaguesListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var allLeaguesLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        allLeaguesLabel.layer.borderWidth = 1
        allLeaguesLabel.layer.borderColor = UIColor.lightGray.cgColor

    }
    
}

extension LeaguesListVC : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: LeagueHorizontalCell.self), for: indexPath) as? LeagueHorizontalCell {
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
    
}


extension LeaguesListVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "LegueVerticalCell"){
            
            cell.imageView?.image = UIImage(named: "premierLeague.jpg")
            cell.textLabel?.text = "English Premier League"
            
            cell.detailTextLabel?.text = "Soccer"
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}
