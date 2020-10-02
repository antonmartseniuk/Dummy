//
//  NetworkServiceProtocol.swift
//  DummyApp
//
//  Created by Anton Martsenyuk on 01.10.2020.
//  Copyright © 2020 Anton Martsenyuk. All rights reserved.
//

import Foundation
import RxSwift

protocol NetworkServiceProtocol {
    func userListRequest(page: Int) -> Observable<[User]>
    func userDetail(with id: String) -> Single<UserProfile>
}
