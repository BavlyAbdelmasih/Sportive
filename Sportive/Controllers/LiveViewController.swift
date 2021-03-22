//
//  LiveViewController.swift
//  Sportive
//
//  Created by Oufaa on 22/03/2021.
//

import UIKit

class LiveViewController: UIViewController {

    @IBOutlet weak var liveTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        liveTableView.delegate = self
        liveTableView.dataSource = self

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
extension LiveViewController : UITableViewDelegate,UITableViewDataSource {

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 10
        }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
                if let cell = self.liveTableView.dequeueReusableCell(withIdentifier: "LiveTableViewCell") as? LiveTableViewCell {
    
                    cell.firstTeamImageView?.image = UIImage(named: "arsenal")
                    cell.secondTeamImageView?.image = UIImage(named: "arsenal")
                    return cell
                }
    
                return UITableViewCell()
    
}
}
