//
//  ViewController.swift
//  TO-DO-List
//
//  Created by Manali Rami on 2018-09-23.
//  Copyright © 2018 Manali Rami. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var todoLabel: UILabel!
    
}
class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

