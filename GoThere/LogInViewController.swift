//
//  LogInViewController.swift
//  GoThere
//
//  Created by Zihan Zhang on 2017/12/12.
//  Copyright © 2017年 Zihan Zhang. All rights reserved.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var SignInOrUp: UISegmentedControl!
    @IBOutlet weak var Comfirm: UIBarButtonItem!
    var isSignIn = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LogIn(_ sender: UIBarButtonItem) {
        let emailtext = email.text
        let passwordtext = password.text
        
        if isSignIn == true {
            Auth.auth().signIn(withEmail: emailtext!, password: passwordtext!) { (user, error) in
                if let u = user {
                    let alert = UIAlertView()
                    alert.title = "Welcome Back!"
                    alert.message = "Sign In Succeed"
                    alert.addButton(withTitle: "Let's Explore")
                    alert.show()
                    self.performSegue(withIdentifier: "LoginSegue", sender: self)
                    SignedIn = true
                }
                else {
                    let alert = UIAlertView()
                    alert.title = "Sorry"
                    alert.message = "Sign In Failed"
                    alert.addButton(withTitle: "Retry")
                    alert.show()
                }
            }
        }
        else {
            Auth.auth().createUser(withEmail: emailtext!, password: passwordtext!, completion: { (user, error) in
                if let u = user {
                    let alert = UIAlertView()
                    alert.title = "Welcome!"
                    alert.message = "Sign Up Succeed"
                    alert.addButton(withTitle: "Sign In")
                    alert.show()
                    
                    self.SignInOrUp.selectedSegmentIndex = 0
                    self.isSignIn = true
                    self.Comfirm.title = "Sign In"
                }
                else {
                    let alert = UIAlertView()
                    alert.title = "Sorry!"
                    alert.message = "Sign Up Failed"
                    alert.addButton(withTitle: "Retry")
                    alert.show()
                }
            })
        }
    }
    
    @IBAction func ValueChanged(_ sender: Any) {
        if isSignIn == true {
            isSignIn = false
            Comfirm.title = "Sign Up"
        }
        else {
            isSignIn = true
            Comfirm.title = "Sign In"
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
