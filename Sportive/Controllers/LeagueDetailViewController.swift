//
//  LeagueDetailViewController.swift
//  Sportive
//
//  Created by Oufaa on 21/03/2021.
//

import UIKit

class LeagueDetailViewController: UIViewController {
    


    @IBOutlet weak var resultView: UIView!
    
    @IBOutlet weak var fixtureView: UIView!
    
    @IBOutlet weak var liveView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        fixtureView.alpha = 1
        resultView.alpha = 0
        liveView.alpha = 0

    }
    
    @IBAction func switchViews(_ sender:UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            fixtureView.alpha = 1
            resultView.alpha = 0
            liveView.alpha = 0
        }else if sender.selectedSegmentIndex == 1 {
            fixtureView.alpha = 0
            resultView.alpha = 0
            liveView.alpha = 1
        }else {
            fixtureView.alpha = 0
            resultView.alpha = 1
            liveView.alpha = 0
        }
    }
    
}
