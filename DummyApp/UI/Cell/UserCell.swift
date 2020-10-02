//
//  UserCell.swift
//  DummyApp
//
//  Created by Anton Martsenyuk on 30.09.2020.
//  Copyright © 2020 Anton Martsenyuk. All rights reserved.
//

import UIKit
import Kingfisher

class UserCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var user: User! {
        didSet { updateCell(user: user) }
    }
}

extension UserCell {
    static func register(to tableView: UITableView) {
        let cellString = String(describing: self)
        let cellNib = UINib(nibName: cellString, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellString)
    }
    
    static var cellHeight: CGFloat = 70
}

private extension UserCell {
    func updateCell(user: User) {
        self.nameLabel.text = user.fullName
        let url = URL(string: user.picture)
        let processor = RoundCornerImageProcessor(cornerRadius: 20)
        iconImageView.kf.indicatorType = .activity
        iconImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "person.circle"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
}
