//
//  ViewController.swift
//  chatApp
//
//  Created by Murad Al Wajed on 21/11/18.
//  Copyright © 2018 Murad Al Wajed. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(handleLogOut))
        
        // User is not logged in
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogOut), with: nil, afterDelay: 0)
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

