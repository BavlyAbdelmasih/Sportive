//
//  FavouriteLeaguesVC.swift
//  Sportive
//
//  Created by iambavly on 3/19/21.
//

import UIKit
import CoreData

class FavouriteLeaguesVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var context :NSManagedObjectContext?
    
    var favLeaguesArray : [FavouriteLeague]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        context = (UIApplication.shared.delegate as? AppDelegate )?.persistentContainer.viewContext
        loadAllData()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadAllData()
    }
    
    func loadAllData() {
        
        let request : NSFetchRequest<FavouriteLeague> = FavouriteLeague.fetchRequest()
        
        do{
            try favLeaguesArray =  (context?.fetch(request))!
            self.tableView.reloadData()
        }catch{
            print("\(error)")
        }
    }
    
    
}

extension FavouriteLeaguesVC : UITableViewDelegate , UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favLeaguesArray?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "LegueVerticalCell") as? LeagueVerticalCell ,  let item = favLeaguesArray?[indexPath.row] {
            
            cell.leagueImage?.sd_setImage(with: URL(string: item.badge!), placeholderImage: UIImage(named: "placeholder.png"))
            cell.leagueName?.text = item.title
            
            cell.leagueSport?.text = item.country
            cell.youtubeImageClicked = {
                if let url = URL(string: "https://\(item.leagueYoutube!)") {
                    UIApplication.shared.open(url)
                }
                
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let details = (self.storyboard?.instantiateViewController(identifier: "LeagueDetailViewController"))as! LeagueDetailsVC
        
        guard let favItem = favLeaguesArray?[indexPath.row] else { return }
        let leagueItem = League(id: favItem.id!, title: favItem.title!, country: favItem.country!, badge: favItem.badge!, leagueYoutube: favItem.leagueYoutube!)
        
        details.leagueItem = leagueItem
        navigationController?.pushViewController( details, animated: true)
        
    }
    
}
