//
//  FixtureViewController.swift
//  Sportive
//
//  Created by Oufaa on 22/03/2021.
//

import UIKit

class FixtureViewController: UIViewController {

    @IBOutlet weak var fixtureTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fixtureTableView.delegate = self
        fixtureTableView.dataSource = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension FixtureViewController : UITableViewDelegate,UITableViewDataSource {

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 10
        }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
                if let cell = self.fixtureTableView.dequeueReusableCell(withIdentifier: "FixtureTableViewCell") as? FixtureTableViewCell {
    
                    cell.firstTeamImageView?.image = UIImage(named: "premierLeague.jpg")
                    cell.secondTeamImageView?.image = UIImage(named: "premierLeague.jpg")
                    return cell
                }
    
                return UITableViewCell()
    
}
}
