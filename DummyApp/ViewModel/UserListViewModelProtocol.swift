//
//  UserListViewModelProtocol.swift
//  DummyApp
//
//  Created by Anton Martsenyuk on 01.10.2020.
//  Copyright © 2020 Anton Martsenyuk. All rights reserved.
//

import Foundation
import RxSwift

protocol UserListViewModelProtocol {
    var isLoadingObservable: Observable<Bool> { get }
    var userListObservable: Observable<[User]> { get }
    
    func setPageTrigger(_ observable: Observable<Void>)
    func didSelectedRow(_ row: Int)
}
