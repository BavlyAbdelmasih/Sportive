//
//  LeagueDetailViewController.swift
//  Sportive
//
//  Created by Oufaa on 21/03/2021.
//

import UIKit

class LeagueDetailsVC: UIViewController {
    
    @IBOutlet weak var futureMatchesView: UIView!
    @IBOutlet weak var LiveMatchesView: UIView!
    
    
    @IBOutlet weak var RecentMatchesView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        LiveMatchesView.alpha = 1
        RecentMatchesView.alpha = 0
        futureMatchesView.alpha = 0
       
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
    
}

