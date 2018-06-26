//
//  loginVC.swift
//  DistanceTravelled
//
//  Created by Sameera Chandimal on 6/25/18.
//  Copyright © 2018 Leonardo Savio Dabus. All rights reserved.
//

import UIKit

class loginVC: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHomeView" {
            if let destinationVC = segue.destination as? ViewController {
                destinationVC.username = usernameTextField.text ?? ""
            }
        }
    }
    
    @IBAction func onClickLogin(_ sender: Any) {
        if usernameTextField.text != "" {
            self.performSegue(withIdentifier: "showHomeView", sender: nil)
        }
    }
}
