//
//  MainAppCoordinator.swift
//  DummyApp
//
//  Created by Anton Martsenyuk on 01.10.2020.
//  Copyright © 2020 Anton Martsenyuk. All rights reserved.
//

import Foundation
import XCoordinator

enum MainAppRouter: Route {
    case userList
    case userProfile
}

class MainAppCoordinator: NavigationCoordinator<MainAppRouter> {
    
    init() {
        super.init(initialRoute: .userList)
    }
    
    override func prepareTransition(for route: MainAppRouter) -> NavigationTransition {
        switch route {
        case .userList:
            let vc = UIStoryboard.mainViewController()
        return .push(vc)
            
        case .userProfile:
            return .none()
        }
    }
}

