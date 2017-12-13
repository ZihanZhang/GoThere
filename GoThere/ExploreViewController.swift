//
//  ExploreViewController.swift
//  GoThere
//
//  Created by Zihan Zhang on 2017/12/12.
//  Copyright © 2017年 Zihan Zhang. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate  {
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
