//
//  MainAppCoordinator.swift
//  DummyApp
//
//  Created by Anton Martsenyuk on 01.10.2020.
//  Copyright © 2020 Anton Martsenyuk. All rights reserved.
//

import Foundation
import XCoordinator
import SwiftUI

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
            vc.unownedRouter = unownedRouter
            return .push(vc)
        case .userProfile:
            if #available(iOS 13, *) {
                let detailView = DetailView()
                let host = UIHostingController(rootView: detailView)
                return .push(host)
            }
            return .none()
        }
    }
}

