//
//  Endpoint.swift
//  NetworkManager
//
//  Created by Yerassyl Zhassuzakhov on 4/30/19.
//  Copyright © 2019 Yerassyl Zhassuzakhov. All rights reserved.
//

import Foundation

enum Endpoint: EndpointType {
    case bookingHistory(token: String)
    
    var baseUrl: URL {
        return URL(string: "http://185.4.73.87/api/")!
    }
    
    var path: String {
        return "my_orders"
    }
    
    var httpMethod: HTTPMethod {
        return .post
    }
    
    var task: HTTPTask {
        switch self {
        case .bookingHistory(let token):
            return .requestParametersAndHeaders(bodyParameters: nil, urlParameters: nil, additionalHeaders: ["token": token])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
