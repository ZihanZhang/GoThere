//
//  DetailsViewController.swift
//  GoThere
//
//  Created by Zihan Zhang on 2017/12/16.
//  Copyright © 2017年 Zihan Zhang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var Details: UITextView!
    var curItem: String?
    
    var handle: DatabaseHandle?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let ref = Database.database().reference()
        
        handle = ref.child("comments").observe(.childAdded, with: {(snapshot) in
            if let item = snapshot.key as? String {
                if item == self.curItem {
                    self.Details.text = snapshot.value as! String
                }
            }
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
