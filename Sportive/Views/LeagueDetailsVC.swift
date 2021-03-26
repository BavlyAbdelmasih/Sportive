//
//  LeagueDetailViewController.swift
//  Sportive
//
//  Created by Oufaa on 21/03/2021.
//

import UIKit
import CoreData

class LeagueDetailsVC: UIViewController {
    
    @IBOutlet weak var futureMatchesView: UIView!
    @IBOutlet weak var LiveMatchesView: UIView!
    @IBOutlet weak var RecentMatchesView: UIView!
    @IBOutlet weak var leagueBadgeImage: UIImageView!
    @IBOutlet weak var favouriteIcon: UIBarButtonItem!
    
    var leagueItem : League?
    var isFavourite = false
    var context :NSManagedObjectContext?
    var favLeaguesArray : [FavouriteLeague]?
    var favLeague : FavouriteLeague?
    var commitPredicate : NSPredicate?
    var searchedLeagues : [FavouriteLeague]?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //show live Matches screen first
        LiveMatchesView.alpha = 1
        RecentMatchesView.alpha = 0
        futureMatchesView.alpha = 0
        
        
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
        
    }
    
    @IBAction func switchViews(_ sender: Any) {
        if (sender as AnyObject).selectedSegmentIndex == 0 {
            LiveMatchesView.alpha = 1
            RecentMatchesView.alpha = 0
            futureMatchesView.alpha = 0
        }else if (sender as AnyObject).selectedSegmentIndex == 1 {
            LiveMatchesView.alpha = 0
            RecentMatchesView.alpha = 1
            futureMatchesView.alpha = 0
        }else {
            LiveMatchesView.alpha = 0
            RecentMatchesView.alpha = 0
            futureMatchesView.alpha = 1
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

