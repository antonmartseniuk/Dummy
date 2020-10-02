//
//  UserListFooterView.swift
//  DummyApp
//
//  Created by Anton Martsenyuk on 01.10.2020.
//  Copyright © 2020 Anton Martsenyuk. All rights reserved.
//

import UIKit

class UserListFooterView: UITableViewHeaderFooterView {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    func startLoadIndicator() {
        self.loadingIndicator.isHidden = false
        self.loadingIndicator.startAnimating()
    }
    
    func stopLoadIndicator() {
        self.loadingIndicator.isHidden = true
        self.loadingIndicator.stopAnimating()
        self.loadingIndicator.hidesWhenStopped = true
    }

}
