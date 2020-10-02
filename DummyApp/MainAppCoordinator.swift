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
    case userProfile(id: String)
}

class MainAppCoordinator: NavigationCoordinator<MainAppRouter> {
    
    private let networkService: NetworkServiceProtocol = NetworkService()
    
    init() {
        super.init(initialRoute: .userList)
    }
    
    override func prepareTransition(for route: MainAppRouter) -> NavigationTransition {
        switch route {
        case .userList:
            let vc = UIStoryboard.mainViewController()
            let viewModel = UserListViewModel(networkService: networkService)
            viewModel.unownedRouter = unownedRouter
            vc.viewModel = viewModel
            return .push(vc)
        case .userProfile(let id):
            if #available(iOS 13, *) {
                let viewModel = DetailViewModel(networkService: networkService, userID: id)
                let detailView = DetailView(viewModel: viewModel)
                let host = UIHostingController(rootView: detailView)
                return .push(host)
            }
            return .none()
        }
    }
}

