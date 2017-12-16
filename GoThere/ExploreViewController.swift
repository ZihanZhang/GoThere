//
//  ExploreViewController.swift
//  GoThere
//
//  Created by Zihan Zhang on 2017/12/12.
//  Copyright © 2017年 Zihan Zhang. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate  {
    var location: String?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recommendations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "recommendationcell")
        
        cell.textLabel?.text = recommendations[indexPath.row].discription
        cell.imageView?.image = recommendations[indexPath.row].picture
        
        return cell
    }
    
    @IBOutlet weak var Advertise: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Advertise.image = #imageLiteral(resourceName: "images.jpeg")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FoodSegue" {
            if let toViewController = segue.destination as? TestViewController {
                toViewController.Category = "FoodSegue"
                toViewController.Location = self.location
            }
        }
        if segue.identifier == "OutdoorSegue" {
            if let toViewController = segue.destination as? DetailViewController {
                toViewController.Category = "OutdoorSegue"
                toViewController.Location = self.location

            }
        }
        if segue.identifier == "HistorySegue" {
            if let toViewController = segue.destination as? DetailViewController {
                toViewController.Category = "HistorySegue"
                toViewController.Location = self.location
            }
        }
        if segue.identifier == "SouvenirSegue" {
            if let toViewController = segue.destination as? DetailViewController {
                toViewController.Category = "SouvenirSegue"
                toViewController.Location = self.location
            }
        }
        if segue.identifier == "EntertainmentSegue" {
            if let toViewController = segue.destination as? DetailViewController {
                toViewController.Category = "EntertainmentSegue"
                toViewController.Location = self.location
            }
        }
        if segue.identifier == "ShoppingSegue" {
            if let toViewController = segue.destination as? DetailViewController {
                toViewController.Category = "ShoppingSegue"
                toViewController.Location = self.location
            }
        }
        if segue.identifier == "SportSegue" {
            if let toViewController = segue.destination as? DetailViewController {
                toViewController.Category = "SportSegue"
                toViewController.Location = self.location
            }
        }
        if segue.identifier == "NatureSegue" {
            if let toViewController = segue.destination as? DetailViewController {
                toViewController.Category = "NatureSegue"
                toViewController.Location = self.location
            }
        }
    }
    
    @IBAction func FoodAct(_ sender: UIButton) {
        
    }

    @IBAction func OutdoorAct(_ sender: UIButton) {
    }
    
    @IBAction func HistoryAct(_ sender: UIButton) {
    }
    

    @IBAction func SouvenirAct(_ sender: UIButton) {
    }

    @IBAction func EntertainmentAct(_ sender: UIButton) {
    }

    @IBAction func ShoppingAct(_ sender: UIButton) {
    }
    
    @IBAction func SportsAct(_ sender: UIButton) {
    }
    
    @IBAction func NatureAct(_ sender: UIButton) {
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
