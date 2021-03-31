//
//  SportsListVC.swift
//  Sportive
//
//  Created by iambavly on 3/19/21.
//

import UIKit
import JGProgressHUD

class SportsListVC: UIViewController ,ReachabilityObserverDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    
    private let viewModel = SportsViewsModel()
    private let spinner = JGProgressHUD(style: .light)
    var items : Sports?
    var userName : String?
    var profilePicUrl : String?
    
    deinit{
        removeReachabilityObserver()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePic.layer.cornerRadius = profilePic.width / 2
        
        viewModel.getApiData(isLoadingCompletion: { isFinished in
            if(!isFinished){
                self.spinner.show(in: self.collectionView ,animated: true)
            }else{
                self.spinner.dismiss(animated: true)
            }
        })
        viewModel.getSports = {viewModel in
            self.items = viewModel.sports
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        try? addReachabilityObserver()
        
        userName = UserDefaults.standard.value(forKey: "user_name") as? String
        profilePicUrl = UserDefaults.standard.value(forKey: "pictureUrl") as? String
        
        guard  userName != nil else{
            let logginScreen = LoginVC()
            let nav = UINavigationController(rootViewController: logginScreen)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false, completion: nil)
            return
        }
        profileName.text = "Hey \(userName!)"
        profilePic.sd_setImage(with: URL(string: profilePicUrl ?? "https://www.kindpng.com/picc/m/76-763217_anonymous-user-png-transparent-png.png"), placeholderImage: UIImage(named: "placeholder.png"))
    }
}

extension SportsListVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items?.all.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SportCell.self), for: indexPath) as? SportCell {
            let title = items?.all[indexPath.row].title
            let id =  items?.all[indexPath.row].id
            let imagePath = "\(id!)i.png"
            self.drawCardBorder(view: cell.contentView)
            cell.sportIcon.image = UIImage(named: imagePath)
            cell.sportTitleLabel.text = title
            
            return cell
        }
        return UICollectionViewCell()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (view.frame.size.width - 20 * 3) / 2
        return CGSize(width: size, height: size )
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc  = (self.storyboard?.instantiateViewController(identifier: String(describing: LeaguesListVC.self)))! as LeaguesListVC
        let leagueVM = self.viewModel.leagueViewModelForSport(sport: (items?.all[indexPath.row])!)
        vc.viewModel = leagueVM
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func drawCardBorder(view : UIView){
        view.layer.cornerRadius = 10.0
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.layer.masksToBounds = true
    }
    
    
    func reachabilityChanged(_ isReachable: Bool) {
        if !isReachable {
            guard let unReachVC = self.storyboard?.instantiateViewController(withIdentifier: String(describing: UnReachbaleVC.self)) else{return}
            let nav = UINavigationController(rootViewController: unReachVC)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: false, completion: nil)
        }else{
            viewModel.getApiData(isLoadingCompletion: { isFinished in
                if(!isFinished){
                    self.spinner.show(in: self.collectionView ,animated: true)
                }else{
                    self.spinner.dismiss(animated: true)
                }
            })
            viewModel.getSports = {viewModel in
                self.items = viewModel.sports
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
}
