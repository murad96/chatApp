//
//  ViewController.swift
//  chatApp
//
//  Created by Murad Al Wajed on 21/11/18.
//  Copyright © 2018 Murad Al Wajed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(handleLogOut))
    }
    
    @objc func handleLogOut(){
        let LoginController = loginController()
        present(LoginController, animated: true, completion: nil)
    }

}

