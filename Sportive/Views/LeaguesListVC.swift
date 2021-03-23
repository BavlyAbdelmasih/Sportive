//
//  LeaguesListVC.swift
//  Sportive
//
//  Created by iambavly on 3/19/21.
//

import UIKit
import SDWebImage
import JGProgressHUD
class LeaguesListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var allLeaguesLabel: UILabel!
    @IBOutlet weak var sportsBackgrundImage: UIImageView!
    @IBOutlet weak var sportTitleLabel: UILabel!
    @IBOutlet weak var sportTypeLbel: UILabel!
    @IBOutlet weak var sportDescribtionLabel: UILabel!
    
    var sportItem : Sport?
    var presenter = LeaguesViewsPresenter()
    var items : Leagues?
    var spinner = JGProgressHUD(style: .light)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sportTitleLabel.text = sportItem?.title
        guard let imageBackground = sportItem?.backgroundImageUrl  else {
            return
        }
        sportTypeLbel.text = sportItem?.type
        sportsBackgrundImage.sd_setImage(with: URL(string: imageBackground), placeholderImage: UIImage(named: "placeholder.png"))
        sportDescribtionLabel.text = sportItem?.description
        
        
        
        
        //get League Data from Server
        presenter.getApiData(sportTitle: sportItem!.title, isLoadingCompletion: { isFinished in
            if(!isFinished){
                self.spinner.show(in: self.collectionView ,animated: true)
            }else{
                self.spinner.dismiss(animated: true)
            }
        })
        presenter.getLeagues = {viewModel in
            self.items = viewModel.leagues!
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.collectionView.reloadData()
            }
        }
    }
    
    
    
    
}

extension LeaguesListVC : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let topLeagues = items?.all[0...10]
        return topLeagues?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: LeagueHorizontalCell.self), for: indexPath) as? LeagueHorizontalCell {
            let item = items?.all[indexPath.row]
            cell.leagueBadgeImage.sd_setImage(with: URL(string: item!.badge), placeholderImage: UIImage(named: "placeholder.png"))
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
    
}


extension LeaguesListVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items?.all.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "LegueVerticalCell") as? LeagueVerticalCell{
            let item = items?.all[indexPath.row]
            
            cell.leagueImage?.sd_setImage(with: URL(string: item!.badge), placeholderImage: UIImage(named: "placeholder.png"))
            cell.leagueName?.text = item?.title
            
            cell.leagueSport?.text = item?.country
            return cell
        }
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let details = (self.storyboard?.instantiateViewController(identifier: "LeagueDetailViewController"))as! LeagueDetailsVC
        
        _ = UIStoryboard(name: "Main", bundle: nil)
        
        navigationController?.pushViewController( details, animated: true)
        
    }
    
}
