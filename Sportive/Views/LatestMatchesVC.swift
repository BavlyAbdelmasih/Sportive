//
//  LatestMatchesVC.swift
//  Sportive
//
//  Created by iambavly on 3/28/21.
//

import UIKit
import SDWebImage

class LatestMatchesVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel : MatchesViewModel?
    var twoTeams : [[Team]?]?{
        didSet{
            self.collectionView.reloadData()

        }
    }
    var matches : Matches?{
        didSet{
            self.collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}



extension LatestMatchesVC : UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return matches?.all?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: LatestMatchesCell.self), for: indexPath) as? LatestMatchesCell{
            cell.contentView.layer.borderWidth = 1
            cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
            cell.contentView.layer.cornerRadius = 20
            cell.homeTeamName.text = twoTeams?[indexPath.row]?[0].teamTitle
            cell.awayTeamName.text = twoTeams?[indexPath.row]?[1].teamTitle
            cell.homeTeamLogo.sd_setImage(with: URL(string: twoTeams?[indexPath.row]?[0].teamLogoImage ?? "" ), for: .normal, placeholderImage: UIImage(named: "placeholder.png"))
            cell.awayTeamLogo.sd_setImage(with: URL(string: twoTeams?[indexPath.row]?[1].teamLogoImage ?? "" ), for: .normal, placeholderImage: UIImage(named: "placeholder.png"))
            cell.matchResult.text = "\((matches?.all?[indexPath.row].homeTeamScore) ?? "?") - \((matches?.all?[indexPath.row].awayTeamScore) ?? "?")"
            cell.matchDate.text = matches?.all?[indexPath.row].dateEvent
            
            cell.didSelectHomeTeam = {
                let detailsVC = (self.storyboard?.instantiateViewController(identifier: String(describing: TeamDetailsVC.self)))as! TeamDetailsVC
                
                let vm = TeamsViewsModel(team: (self.twoTeams?[indexPath.row]?[0])!)
                detailsVC.viewMdel = vm
                self.present(detailsVC, animated: true, completion: nil)
            }
            
            cell.didSelectAwayTeam = {
                
                let detailsVC = (self.storyboard?.instantiateViewController(identifier: String(describing: TeamDetailsVC.self)))as! TeamDetailsVC
                
                let vm = TeamsViewsModel(team: (self.twoTeams?[indexPath.row]?[1])!)
                detailsVC.viewMdel = vm
                self.present(detailsVC, animated: true, completion: nil)
            }

            

            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
}
