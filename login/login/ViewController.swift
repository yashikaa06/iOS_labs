//
//  ViewController.swift
//  login
//
//  Created by Yashika Geed on 29/07/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var forgotUsernameButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logInAction(_ sender: Any) {
        
    }
    @IBAction func forgotUsernameTapped(_ sender: Any) {
        performSegue(withIdentifier: "LogIn", sender: sender)
    }
    
    @IBAction func forgotPasswordTapped(_ sender: Any) {
        performSegue(withIdentifier: "LogIn", sender: sender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination
        guard let senderButton = sender as? UIButton else { return }

        if senderButton == forgotPasswordButton {
            destinationVC.navigationItem.title = "Forgot Password"
        } else if senderButton == forgotUsernameButton {
            destinationVC.navigationItem.title = "Forgot Username"
        } else {
            destinationVC.navigationItem.title = username.text
        }
    }


    
}

