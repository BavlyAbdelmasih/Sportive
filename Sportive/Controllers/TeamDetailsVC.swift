//
//  TeamDetailsVC.swift
//  Sportive
//
//  Created by iambavly on 3/19/21.
//

import UIKit

class TeamDetailsVC: UIViewController {

    @IBOutlet weak var teamShirt: UIImageView!
    @IBOutlet weak var teamLogo: UIView!
    @IBOutlet weak var stadiumImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        stadiumImage.layer.cornerRadius = 20
        stadiumImage.clipsToBounds = true
        
          }
    


}
