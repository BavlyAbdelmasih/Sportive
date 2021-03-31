//
//  LoginVC.swift
//  Sportive
//
//  Created by iambavly on 3/27/21.
//

//
//  LoginViewController.swift
//  Chatify
//
//  Created by iambavly on 3/8/21.
//

import UIKit
import FBSDKCoreKit
import JGProgressHUD
import FBSDKLoginKit



class LoginVC: UIViewController, UITextFieldDelegate {
    
    private let spinner = JGProgressHUD(style: .light)
    
    private let scrollView : UIScrollView = {
        let frame = UIScrollView()
        
        frame.clipsToBounds = true
        
        return frame
    }()
    
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "mlb-logo.png")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let nameField : UITextField = {
        let field = UITextField()
        
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.borderStyle = .roundedRect
        field.layer.borderWidth = 2
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "name..."
        field.backgroundColor = .white
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        
        return field
    }()
    
    
    private let buttonLogIn :UIButton = {
        
        let button = UIButton()
        
        button.setTitle("Get Started", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.purple.cgColor
        button.layer.borderWidth = 2
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(UIColor.purple, for: .normal)
        button.clipsToBounds = true
        
        return button
    }()
    
    private let orText : UITextView = {
        let text  = UITextView()
        text.text = "OR"
        text.font = .systemFont(ofSize: 20, weight: .bold)
        return text
    }()
    
    private let facebookLoginButton : FBLoginButton = {
        
        let facebookLoginButton = FBLoginButton()
        facebookLoginButton.permissions = ["public_profile", "email"]
        return facebookLoginButton
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        buttonLogIn.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        facebookLoginButton.delegate = self
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(nameField)
        scrollView.addSubview(buttonLogIn)
        scrollView.addSubview(orText)
        scrollView.addSubview(facebookLoginButton)
        
    }
    
    @objc func didTapLogin(){
        if nameField.text! != "" {
            UserDefaults.standard.setValue(nameField.text, forKey: "user_name")

      
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
        alertTheUser()
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        imageView.frame = CGRect(x: (scrollView.width - size)/2 , y: scrollView.height/4, width: size, height: size)
        nameField.frame = CGRect(x: 30, y: imageView.bottom + 40, width: scrollView.width - 60 , height: 52)
        buttonLogIn.frame = CGRect(x: 30, y: nameField.bottom + 20, width: scrollView.width - 60 , height: 52)
        orText.frame = CGRect(x: ( scrollView.width / 2 - orText.width / 2) , y: buttonLogIn.bottom + 20, width: 50 , height: 30)
       facebookLoginButton.center = view.center
        facebookLoginButton.frame = CGRect(x: 30, y: orText.bottom + 20, width: scrollView.width - 60 , height: 52)
    }
    

    private func alertTheUser(){
        
        let alert = UIAlertController(title: "WOOPS", message: "Enter Your Name Please", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Retry", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    

    
}

extension LoginVC : LoginButtonDelegate{
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        guard let token = result?.token?.tokenString , error == nil else{
            return
        }
        
        let facebookRequest = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields":"email, name, first_name, last_name, picture.type(large)"], tokenString: token, version: nil, httpMethod: .get)
        
        facebookRequest.start(completionHandler: { [self]_ , result , error in
            guard let result = result as? [String : Any] , error == nil else{
                print("error1")
                return
            }
            
            guard
                  let firstName = result["first_name"] as? String,
                  let image = result["picture"] as? [String : Any],
                  let data = image["data"] as? [String : Any],
                  let pictureUrl = data["url"] as? String else{
                print("error2")
                return
            }
            
            spinner.show(in: view)
            print(firstName)
            print(pictureUrl)

            UserDefaults.standard.setValue(firstName, forKey: "user_name")
            UserDefaults.standard.setValue(pictureUrl, forKey: "pictureUrl")
            self.navigationController?.dismiss(animated: true, completion: {
                self.spinner.dismiss()
            })
            
        })
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        //nothing here
    }
    
    
}
