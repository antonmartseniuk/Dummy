//
//  NetworkService.swift
//  DummyApp
//
//  Created by Anton Martsenyuk on 30.09.2020.
//  Copyright © 2020 Anton Martsenyuk. All rights reserved.
//

import Foundation
import Alamofire

final class NetworkService {
    private let interceptor = RequestInterceptor()
    private let alamofire: Session
    
    init() {
        self.alamofire = Session(interceptor: interceptor)
    }
}

extension NetworkService {
    
    func userListRequest(page: Int, limit: Int,
                         completion: @escaping (Result<[User], AFError>) -> Void) {
        let route: UserRouter = .fecthUsersList(page: page, limit: limit)
        
        alamofire.request(route)
            .validate()
            .responseDecodable(of: UserResponse.self) { result in
                switch result.result {
                case .success(let userResponse): completion(.success(userResponse.data))
                case .failure(let error): completion(.failure(error))
                }
        }
    }
    
    func userDetail(with id: String, completion: @escaping (Result<UserProfile, AFError>) -> Void) {
        let route: UserRouter = .userDetail(id: id)
        
        alamofire.request(route)
            .validate()
            .responseDecodable(of: UserProfile.self) { result in
                switch result.result {
                case .success(let profile): completion(.success(profile))
                case .failure(let error): completion(.failure(error))
                }
        }
    }
}
