//
//  ViewController.swift
//  DummyApp
//
//  Created by Anton Martsenyuk on 30.09.2020.
//  Copyright © 2020 Anton Martsenyuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let networkService = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func test(_ sender: Any) {
        networkService.userListRequest(page: 0, limit: 20) { result in
            switch result {
            case .success(let users): print(users)
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
    
}

