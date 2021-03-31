//
//  FavouriteLeaguesVC.swift
//  Sportive
//
//  Created by iambavly on 3/19/21.
//

import UIKit
import CoreData
import FBSDKLoginKit

class FavouriteLeaguesVC: UIViewController , ReachabilityObserverDelegate {
    @IBOutlet weak var tableView: UITableView!
    var context :NSManagedObjectContext?
    var viewModel : LeaguesViewsModel?
    var isReachable = true
    var matchVM : MatchesViewModel?
    var teamVM :TeamsViewsModel?
    var favLeaguesArray : [FavouriteLeague]?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        try? addReachabilityObserver()
        context = (UIApplication.shared.delegate as? AppDelegate )?.persistentContainer.viewContext
        loadAllData()
    }
    
    
    @objc func didTapTheButton(){
        
        UserDefaults.standard.setValue(nil, forKey: "user_name")
        UserDefaults.standard.setValue(nil, forKey: "pictureUrl")
        
        let loginManager = LoginManager()
        loginManager.logOut()
        let logginScreen = LoginVC()
        let nav = UINavigationController(rootViewController: logginScreen)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: false, completion: nil)
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
            
            cell.leagueImage.sd_setImage(with: URL(string: item.badge ?? "placeholder.png"), placeholderImage: UIImage(named: "placeholder.png"))
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
        
        if(isReachable){
            let details = (self.storyboard?.instantiateViewController(identifier: "LeagueDetailViewController"))as! LeagueDetailsVC
            
            guard let favItem = favLeaguesArray?[indexPath.row] else { return }
            let leagueItem = League(id: favItem.id!, title: favItem.title!, country: favItem.country!, badge: favItem.badge!, leagueYoutube: favItem.leagueYoutube!)
            
            details.leagueItem = leagueItem
            
            matchVM = MatchesViewModel(league: leagueItem)
            teamVM = TeamsViewsModel(league: leagueItem)
            performSegue(withIdentifier: "fromFavouriteToDetails", sender: self)
            
            
        }else{
            let alert = UIAlertController(title: "Sorry", message: "There is no internet Connection", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Retry", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailsVC = segue.destination as? LeagueDetailsVC
        detailsVC?.matchViewModel = matchVM
        detailsVC?.teamsViewModel = teamVM
    }
    
    func reachabilityChanged(_ isReachable: Bool) {
        self.isReachable = isReachable
        if isReachable{
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action:#selector(didTapTheButton))
        }
    }
    
}
