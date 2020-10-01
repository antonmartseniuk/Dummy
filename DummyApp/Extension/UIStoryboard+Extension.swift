//
//  UIStoryboard+Extension.swift
//  DummyApp
//
//  Created by Anton Martsenyuk on 01.10.2020.
//  Copyright © 2020 Anton Martsenyuk. All rights reserved.
//

import UIKit

enum Storyboard: String {
    case main
    case detail
}

extension UIStoryboard {
    
    static func mainViewController() -> ViewController {
        return UIStoryboard(.main).instantiateViewController(with: ViewController.self)
    }
}

private extension UIStoryboard {
    convenience init(_ storyboard: Storyboard) {
        self.init(name: storyboard.rawValue.capitalized, bundle: .main)
    }
    
    func instantiateViewController<T: UIViewController>(with class: T.Type) -> T {
        return instantiateViewController(withIdentifier: String(describing: T.self)) as! T
    }
}
