//
//  UIScrollView+Extension.swift
//  DummyApp
//
//  Created by Anton Martsenyuk on 30.09.2020.
//  Copyright © 2020 Anton Martsenyuk. All rights reserved.
//

import UIKit

extension UITableView {
    func isNearBottomEdge(edgeOffset: CGFloat = 20.0) -> Bool {
        return self.contentOffset.y + self.frame.size.height + edgeOffset > self.contentSize.height
    }
}
