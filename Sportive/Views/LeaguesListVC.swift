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
    
    var viewModel : LeaguesViewsModel?
    var items : Leagues?
    var spinner = JGProgressHUD(style: .light)
    var matchVM:MatchesViewModel?
    var teamVM : TeamsViewsModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sportTitleLabel.text = viewModel?.sport.title
        
        
        guard let imageBackground = viewModel?.sport.backgroundImageUrl else { return  }
        sportTypeLbel.text = viewModel?.sport.type
        sportsBackgrundImage.sd_setImage(with: URL(string: imageBackground), placeholderImage: UIImage(named: "placeholder.png"))
        sportDescribtionLabel.text = viewModel?.sport.description
        
        //get League Data from Server
        viewModel?.getApiData(isLoadingCompletion: { isFinished in
            if(!isFinished){
                self.spinner.show(in: self.collectionView ,animated: true)
            }
        })
        viewModel?.getLeagues = {viewModel in
            self.items = viewModel.leagues!
            self.spinner.dismiss(animated: true)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.collectionView.reloadData()
            }
        }
    }
}

extension LeaguesListVC : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         items?.all.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TeamsInLeagueCell.self), for: indexPath) as? TeamsInLeagueCell , let item = items?.all[indexPath.row] {
            
            cell.leagueBadgeImage.sd_setImage(with: URL(string: item.badge ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
            cell.leagueBadgeImage.layer.cornerRadius = cell.leagueBadgeImage.frame.width / 2
            cell.leagueBadgeImage.layer.borderWidth = 2
            cell.leagueBadgeImage.layer.borderColor = UIColor.lightGray.cgColor
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        matchVM = self.viewModel!.MatchesViewModelForLeague(league: (items?.all[indexPath.row])!)
        teamVM = self.viewModel!.TeamsViewModelForLeague(league: (items?.all[indexPath.row])!)
        performSegue(withIdentifier: "fromLeagueListToDetails", sender: self)
    }
    
    
    
}


extension LeaguesListVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items?.all.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "LegueVerticalCell") as? LeagueVerticalCell ,  let item = items?.all[indexPath.row] {
            
            cell.leagueImage?.sd_setImage(with: URL(string: item.badge ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
            cell.leagueName?.text = item.title
            
            cell.leagueSport?.text = item.country
            cell.youtubeImageClicked = {
                guard let youtubeUrlStr = item.leagueYoutube  else {
                    return
                }
                if let url = URL(string: "https://\(youtubeUrlStr)") {
                    UIApplication.shared.open(url)
                }                
            }
            cell.leagueImage.layer.cornerRadius = cell.leagueImage.frame.width / 2
            cell.leagueImage.layer.borderWidth = 2
            cell.leagueImage.layer.borderColor = UIColor.purple.cgColor
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        matchVM = self.viewModel!.MatchesViewModelForLeague(league: (items?.all[indexPath.row])!)
        teamVM = self.viewModel!.TeamsViewModelForLeague(league: (items?.all[indexPath.row])!)
        performSegue(withIdentifier: "fromLeagueListToDetails", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailsVC = segue.destination as? LeagueDetailsVC
        detailsVC?.matchViewModel = matchVM
        detailsVC?.teamsViewModel = teamVM
    }
    
}
