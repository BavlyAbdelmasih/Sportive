//
//  LeagueDetailViewController.swift
//  Sportive
//
//  Created by Oufaa on 21/03/2021.
//

import UIKit
import CoreData
import JGProgressHUD

class LeagueDetailsVC: UIViewController {
    
    @IBOutlet weak var leagueBadgeImage: UIImageView!
    @IBOutlet weak var favouriteIcon: UIBarButtonItem!
    @IBOutlet weak var latestMatchesView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    private let spinner = JGProgressHUD(style: .light)
    var leagueItem : League?
    var isFavourite = false
    var context :NSManagedObjectContext?
    var favLeaguesArray : [FavouriteLeague]?
    var favLeague : FavouriteLeague?
    var commitPredicate : NSPredicate?
    var searchedLeagues : [FavouriteLeague]?
    var matchViewModel : MatchesViewModel!
    var teamsViewModel : TeamsViewsModel!
    var teamItems : Teams?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leagueItem = matchViewModel?.league
        
        context = (UIApplication.shared.delegate as? AppDelegate )?.persistentContainer.viewContext
        
        //check if this league is in favourite leagues
        guard let id = leagueItem?.id else{ return }
        commitPredicate = NSPredicate(format: "id == %@",id )   //check if this league is in favourite leagues
        loadTargetData()
        
        
        isFavourite = false
        
        if searchedLeagues!.count > 0 {
            isFavourite = true
        }
        loadAllData()
        
        //change icon to heart fill if league is favourite
        favouriteIcon.image = isFavourite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        
        //leaegue badge image
        leagueBadgeImage.sd_setImage(with: URL(string: leagueItem!.badge ?? "placeholder.png"), placeholderImage: UIImage(named: "placeholder.png"))
        
        guard let latestVC = self.children.first as? LatestMatchesVC else  {
            fatalError("Check storyboard for missing LocationTableViewController")
        }
        
        guard let UpcomingVC = self.children.last as? UpcomingMatchesVC else  {
            fatalError("Check storyboard for missing LocationTableViewController")
        }
        
        
        matchViewModel?.getDataFromApiServer(isLoadingCompletion: {isFinishsed in
            
            if(!isFinishsed){
                self.spinner.show(in: self.view)
            }else{
                self.spinner.dismiss(animated: true)
                self.teamsViewModel?.getDataFromApiServer(isLoadingCompletion: {isFinishsed in
                    
                    if(!isFinishsed){
                        self.spinner.show(in: self.view)
                    }else{
                        self.spinner.dismiss(animated: true)
                        
                        
                        self.matchViewModel.getTwoTeamsForMatches(teams: self.teamItems, isLoadingCompletion: {isFinished in
                            
                            if(isFinished){
                                latestVC.twoTeams = self.matchViewModel.twoTeams
                                UpcomingVC.twoTeams = self.matchViewModel.twoTeams
                            }
                        })
                    }
                })
            }
        })
        
        matchViewModel?.getData = {vm in
            
            latestVC.matches = vm.matches
            UpcomingVC.matches = vm.matches
            
        }
        
        
        
        
        teamsViewModel?.getData = {vm in
            self.teamItems = vm.teams
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
        
    }
    
    
    
    @IBAction func favouriteLeagueAction(_ sender: Any)  {
        if !isFavourite {
            favLeague = FavouriteLeague(context: context!)
            favLeague!.title = leagueItem?.title
            favLeague!.country = leagueItem?.country
            favLeague?.badge = leagueItem?.badge
            favLeague!.leagueYoutube = leagueItem?.leagueYoutube
            favLeague!.id = leagueItem?.id
            
            searchedLeagues?.append(favLeague!)
            do{
                try saveData()
                favouriteIcon.image = UIImage(systemName: "heart.fill")
            }catch{
                print("\(error)")
            }
            
        }else{
            favLeaguesArray = favLeaguesArray?.filter { $0.id != leagueItem?.id}
            context?.delete(searchedLeagues![0])
            
            do{
                try saveData()
                
            }catch{
                
            }
            
            favouriteIcon.image = UIImage(systemName: "heart")
        }
        
        isFavourite = !isFavourite
        
    }
    
    func saveData() throws{
        try context?.save()
    }
    
    func loadTargetData() {
        let request : NSFetchRequest<FavouriteLeague> = FavouriteLeague.fetchRequest()
        request.predicate = commitPredicate
        
        do{
            try searchedLeagues =  (context?.fetch(request))!
        }catch{
            print("\(error)")
        }
    }
    
    func loadAllData() {
        let request : NSFetchRequest<FavouriteLeague> = FavouriteLeague.fetchRequest()
        
        do{
            try favLeaguesArray =  (context?.fetch(request))!
        }catch{
            print("\(error)")
        }
    }
}



extension LeagueDetailsVC : UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        teamItems?.all?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TeamsInLeagueCell.self), for: indexPath) as? TeamsInLeagueCell , let item = teamItems?.all?[indexPath.row] {
            
            cell.leagueBadgeImage.sd_setImage(with: URL(string: item.teamLogoImage), placeholderImage: UIImage(named: "placeholder.png"))
            cell.leagueBadgeImage.layer.cornerRadius = cell.leagueBadgeImage.frame.width / 2
            cell.leagueBadgeImage.layer.borderWidth = 2
            cell.leagueBadgeImage.layer.borderColor = UIColor.lightGray.cgColor
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVC = (self.storyboard?.instantiateViewController(identifier: String(describing: TeamDetailsVC.self)))as! TeamDetailsVC
        let vm = self.teamsViewModel.TeamsViewModelForTeam(team: (teamItems?.all?[indexPath.row])!)
        detailsVC.viewMdel = vm
        self.present(detailsVC, animated: true, completion: nil)
    }
    
}


