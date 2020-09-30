//
//  UserRouter.swift
//  DummyApp
//
//  Created by Anton Martsenyuk on 30.09.2020.
//  Copyright © 2020 Anton Martsenyuk. All rights reserved.
//

import Foundation
import Alamofire

enum UserRouter {
    case fecthUsersList(page: Int, limit: Int)
    case userDetail(id: String)
}

extension UserRouter {
    var baseURL: String {
        return "https://dummyapi.io"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .fecthUsersList: return "/data/api/user"
        case .userDetail(let id): return "/data/api/user/\(id)"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .fecthUsersList(let page, let limit):
            return ["page": page, "limit": limit]
        case .userDetail:
            return nil
        }
    }
}

extension UserRouter: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
                
        if let parameters = self.parameters {
            request = try URLEncoding.queryString.encode(request, with: parameters)
        }
        
        request.method = method
        return request
    }
}
