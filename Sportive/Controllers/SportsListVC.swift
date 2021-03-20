//
//  SportsListVC.swift
//  Sportive
//
//  Created by iambavly on 3/19/21.
//

import UIKit

class SportsListVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var i : Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        i = 102

    }
    

}

extension SportsListVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 19
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SportCell.self), for: indexPath) as? SportCell {
           
            cell.sportCellViewBg.layer.cornerRadius = 10.0
            cell.sportCellViewBg.layer.borderWidth = 1.0
            cell.sportCellViewBg.layer.borderColor = UIColor.systemGray.cgColor
            cell.sportCellViewBg.layer.masksToBounds = true

            cell.sportCellViewBg.layer.shadowColor = UIColor.gray.cgColor
            cell.sportCellViewBg.layer.shadowOffset = CGSize(width: 5, height: 5)
            cell.sportCellViewBg.layer.shadowRadius = 2
            cell.sportCellViewBg.layer.shadowOpacity = 0.5
            cell.sportCellViewBg.layer.masksToBounds = false

           
            cell.sportIcon.image = UIImage(named: "\(i ?? 112)i.png")
            i = i + 1
        
            return cell

        }
        
            return UICollectionViewCell()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let size = (view.frame.size.width - 60) / 2
            return CGSize(width: size, height: size - 10)
        }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc  = (self.storyboard?.instantiateViewController(identifier: String(describing: LeaguesListVC.self)))! as LeaguesListVC
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
