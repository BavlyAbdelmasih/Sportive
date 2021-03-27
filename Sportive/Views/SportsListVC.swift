//
//  SportsListVC.swift
//  Sportive
//
//  Created by iambavly on 3/19/21.
//

import UIKit
import JGProgressHUD

class SportsListVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let presenter = SportsViewsModel()
    private let spinner = JGProgressHUD(style: .light)
    private var items : Sports?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getApiData(isLoadingCompletion: { isFinished in
            if(!isFinished){
                self.spinner.show(in: self.collectionView ,animated: true)
            }else{
                self.spinner.dismiss(animated: true)
            }
        })
        presenter.getSports = {viewModel in
            self.items = viewModel.sports
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

extension SportsListVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items?.all.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SportCell.self), for: indexPath) as? SportCell {
            let title = items?.all[indexPath.row].title
            let id =  items?.all[indexPath.row].id
            let imagePath = "\(id!)i.png"
            self.drawCardBorder(view: cell.sportCellViewBg)
            cell.sportIcon.image = UIImage(named: imagePath)
            cell.sportTitleLabel.text = title
            
            return cell
        }
        return UICollectionViewCell()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (view.frame.size.width - 20 * 3) / 2
        return CGSize(width: size, height: size - 10)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc  = (self.storyboard?.instantiateViewController(identifier: String(describing: LeaguesListVC.self)))! as LeaguesListVC
        
        let leagueVM = self.presenter.leagueViewModelForSport(sport: (items?.all[indexPath.row])!)
        vc.viewModel = leagueVM
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func drawCardBorder(view : UIView){
        view.layer.cornerRadius = 10.0
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.layer.masksToBounds = true
        
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 5, height: 5)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.5
        view.layer.masksToBounds = false
    }
}
