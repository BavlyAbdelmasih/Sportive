//
//  UnReachbaleVC.swift
//  Sportive
//
//  Created by iambavly on 3/30/21.
//

import UIKit

class UnReachbaleVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func reloadClickListener(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func favouriteClickListener(_ sender: Any) {
        
        guard let favVc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: FavouriteLeaguesVC.self)) else{return}
        self.navigationController?.pushViewController(favVc, animated: true)
    }
}
