//
//  UpcomingMatchesVC.swift
//  Sportive
//
//  Created by iambavly on 3/28/21.
//

import UIKit

class UpcomingMatchesVC: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}



extension UpcomingMatchesVC : UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UpcomingMatchesCell.self), for: indexPath) as? UpcomingMatchesCell{
            cell.contentView.layer.borderWidth = 1
            cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
            cell.contentView.layer.cornerRadius = 20
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
}
