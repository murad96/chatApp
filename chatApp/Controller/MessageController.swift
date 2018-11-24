//
//  ViewController.swift
//  chatApp
//
//  Created by Murad Al Wajed on 21/11/18.
//  Copyright © 2018 Murad Al Wajed. All rights reserved.
//

import UIKit
import Firebase
class MessageController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(handleLogOut))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "compose"), style: .plain, target: self, action: #selector(handleNewMessage))
        // User is not logged in
        checkIfUserIsLoggedIn()
    }
    @objc func handleNewMessage(){
        let newMessageController = NewMessageController()
        let navController = UINavigationController(rootViewController: newMessageController)
        present(navController, animated: true, completion: nil)
    }
    func checkIfUserIsLoggedIn(){
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogOut), with: nil, afterDelay: 0)
        }else {
            let uid = Auth.auth().currentUser?.uid
            print(uid)
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot .value as? [String: AnyObject]{
                    self.navigationItem.title = dictionary["name"] as? String
                }
            }, withCancel: nil)
        }
    }
    @objc func handleLogOut(){
        do {
            try Auth.auth().signOut()
        }catch let logoutError {
            print(logoutError)
        }
        
        let LoginController = loginController()
        present(LoginController, animated: true, completion: nil)
    }

}

