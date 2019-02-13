//
//  LoginViewController.swift
//  YouMightWin
//
//  Created by James Jacoby on 2/7/19.
//  Copyright © 2019 Moby, Inc. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginAction(_ sender: Any) {
        guard let username = usernameInput.text, !username.isEmpty,
            let password = passwordInput.text, !password.isEmpty else {

            showMessage("Username and password are required")
            
            return
        }
        
        let params = [
            "username": username,
            "password": password
        ]
        
        Alamofire.request("https://45kal3jvm8.execute-api.us-west-2.amazonaws.com/live/session", method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).response { response in
            if response.response?.statusCode == 200 {
                self.performSegue(withIdentifier: "showContest", sender: self)
            } else {
                self.showMessage("Invalid username or password")
            }
        }
    }
    
    func showMessage(_ message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

