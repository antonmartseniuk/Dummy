//
//  DetailViewModel.swift
//  DummyApp
//
//  Created by Anton Martsenyuk on 02.10.2020.
//  Copyright © 2020 Anton Martsenyuk. All rights reserved.
//

import Foundation
import RxSwift
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var userProfile: UserProfile = .emptyProfile()
    
    private var userID: String
    var bag = DisposeBag()
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol, userID: String) {
        self.networkService = networkService
        self.userID = userID
    }
}

extension DetailViewModel {
    func getUserDetails() {
        _ = networkService
            .userDetail(with: userID)
            .subscribe(onSuccess: {[weak self] profile in
                self?.userProfile = profile
            })
        
    }
}
