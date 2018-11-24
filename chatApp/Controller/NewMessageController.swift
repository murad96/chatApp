//
//  NewMessageController.swift
//  chatApp
//
//  Created by Murad Al Wajed on 24/11/18.
//  Copyright © 2018 Murad Al Wajed. All rights reserved.
//

import UIKit
import Firebase
class NewMessageController: UITableViewController {

    let cellId = "cellId"
    var users = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        print("Came")
        fetchUser()
    }
    func fetchUser(){
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            print(snapshot)
            
        }, withCancel: nil)
    }
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        cell.textLabel!.text = "jsahfjskdfhjdsf"
        return cell
    }
}
