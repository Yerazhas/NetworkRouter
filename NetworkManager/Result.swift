//
//  Result.swift
//  NetworkManager
//
//  Created by Yerassyl Zhassuzakhov on 4/30/19.
//  Copyright © 2019 Yerassyl Zhassuzakhov. All rights reserved.
//

import Foundation

enum Result<T: Decodable> {
    case failure(String)
    case success(T)
}
