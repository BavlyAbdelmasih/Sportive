//
//  LiveResultsVC.swift
//  Sportive
//
//  Created by iambavly on 3/22/21.
//

import UIKit

class LiveResultsVC: UIViewController {


    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}


extension LiveResultsVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LiveScoreCell") as? LiveScoreCell
        else {
            return UITableViewCell()
        }
        
        
        return cell
    }
    
    
}
