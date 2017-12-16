//
//  CommentViewController.swift
//  GoThere
//
//  Created by Zihan Zhang on 2017/12/16.
//  Copyright © 2017年 Zihan Zhang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CommentViewController: UIViewController {
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Commenta: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.JPG")!)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "background.JPG")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func SubmitComment(_ sender: Any) {
        print(Name.text)
        print(Commenta.text)
        let ref = Database.database().reference()
        
        if Commenta.text != "" {
            let comment = Commenta.text
            let placeid = Name.text!
            ref.child("comments").child(placeid).setValue(comment)
            
            let alert = UIAlertView()
            alert.title = "Success"
            alert.message = "Comment Succeed!"
            alert.addButton(withTitle: "Got it!")
            alert.show()
        }
        
        else {
            let alert = UIAlertView()
            alert.title = "Error"
            alert.message = "Please input something!"
            alert.addButton(withTitle: "Got it!")
            alert.show()
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
