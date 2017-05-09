//
//  PrivacyTableViewController.swift
//  Life
//
//  Created by Tyler Wilson on 4/13/17.
//  Copyright © 2017 Tyler Wilson. All rights reserved.
//

import UIKit

class PrivacyTableViewController: UITableViewController {
    
        
    private let apps = ["Location","Calendar", "Reminders", "Health"]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.contentInset.top = 20
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.font = UIFont(name: "Kohinoor Bangla", size: 20)
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = apps[indexPath.item]
        return cell
    }
    
    
    
    
    


}
