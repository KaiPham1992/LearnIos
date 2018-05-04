//
//  ViewController.swift
//  DemoUnitTest
//
//  Created by Kai Pham on 4/23/18.
//  Copyright © 2018 Kai Pham. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var service: UserServiceProtocol!
    var users = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
        service = UserService()
        users = service.getUsers()
    }
}

