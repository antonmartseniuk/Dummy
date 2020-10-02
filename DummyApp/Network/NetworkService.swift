//
//  NetworkService.swift
//  DummyApp
//
//  Created by Anton Martsenyuk on 30.09.2020.
//  Copyright © 2020 Anton Martsenyuk. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

final class NetworkService {
    private let interceptor = RequestInterceptor()
    private let alamofire: Session
    
    init() {
        self.alamofire = Session(interceptor: interceptor)
    }
}

extension NetworkService: NetworkServiceProtocol{
    
    func userListRequest(page: Int) -> Observable<[User]> {
        return Observable.create { [weak self] observer -> Disposable in
            let route: UserRouter = .fecthUsersList(page: page, limit: 20)
            
            self?.alamofire.request(route)
                .validate()
                .responseDecodable(of: UserResponse.self) { result in
                    switch result.result {
                    case .success(let userResponse):
                        observer.onNext(userResponse.data)
                    case .failure(let error): observer.onError(error)
                    }
            }
            return Disposables.create()
        }
    }
    
    func userDetail(with id: String) -> Single<UserProfile> {
        return Single.create { [weak self] single -> Disposable in
            let route: UserRouter = .userDetail(id: id)
            
            self?.alamofire.request(route)
                .validate()
                .responseDecodable(of: UserProfile.self) { result in
                    switch result.result {
                    case .success(let profile): single(.success(profile))
                    case .failure(let error): single(.error(error))
                    }
            }
            return Disposables.create()
        }
    }
}
