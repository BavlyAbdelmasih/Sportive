//
//  LeagueDetailViewController.swift
//  Sportive
//
//  Created by Oufaa on 21/03/2021.
//

import UIKit

class LeagueDetailsVC: UIViewController {
    
    @IBOutlet weak var eventsToolBar: UIToolbar!
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet weak var resultsView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toolBar.layer.cornerRadius = 20
        guard let vc  = self.storyboard?.instantiateViewController(identifier: "LiveResults") as? LiveResultsVC else{
            return
        }
        
        vc.view.frame = self.resultsView.bounds
        self.resultsView.addSubview(vc.view)
        self.addChild(vc)
        vc.didMove(toParent: self)
    }
    
    @IBAction func futureMatches(_ sender: Any) {
        guard let vc  = self.storyboard?.instantiateViewController(identifier: "LiveResults") as? LiveResultsVC else{
            return
        }
        
        
        vc.view.frame = self.resultsView.bounds
        self.resultsView.addSubview(vc.view)
        self.addChild(vc)
        vc.didMove(toParent: self)
        
    }
    @IBAction func LiveResults(_ sender: Any) {
        guard let vc  = self.storyboard?.instantiateViewController(identifier: "FutureMatchesVC") as? FutureMatchesVC else {
            return
        }
        

        vc.view.frame = self.resultsView.bounds
        self.resultsView.addSubview(vc.view)
        self.addChild(vc)
        vc.didMove(toParent: self)
        
        
    }
    
}

