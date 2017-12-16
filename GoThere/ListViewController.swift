//
//  ListViewController.swift
//  GoThere
//
//  Created by Zihan Zhang on 2017/12/16.
//  Copyright © 2017年 Zihan Zhang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var curLib: [String] = []
    var curList: [String] = []
    var Category: String?
    
    @IBOutlet weak var myTableView: UITableView!
    var handle: DatabaseHandle?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return curList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "listcell")
        cell.textLabel?.text = curList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            if let toViewController = segue.destination as? DetailsViewController {
                toViewController.curItem = curList[(myTableView.indexPathForSelectedRow?.row)!]
            }
        }
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updataList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updataList() {
        if Category == "FoodSegue" {
            curLib = foodLib
        }
        if Category == "OutdoorSegue" {
            curLib = outdoorLib
        }
        if Category == "HistorySegue" {
            curLib = historyLib
        }
        if Category == "SouvenirSegue" {
            curLib = souvenirLib
        }
        if Category == "EntertainmentSegue" {
            curLib = entertainmentLib
        }
        if Category == "ShoppingSegue" {
            curLib = shoppingLib
        }
        if Category == "SportSegue" {
            curLib = sportLib
        }
        if Category == "NatureSegue" {
            curLib = natureLib
        }
        
        // Do any additional setup after loading the view.
        let ref = Database.database().reference()
        
        handle = ref.child("comments").observe(.childAdded, with: {(snapshot) in
            if let item = snapshot.key as? String {
                for i in self.curLib {
//                    print(i)
                    if (snapshot.key.range(of: i) != nil) {
                        self.curList.append(item)
                        break
                    }
                }
                self.myTableView.reloadData()
            }
        })
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
