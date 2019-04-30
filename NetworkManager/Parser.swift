//
//  Parser.swift
//  NetworkManager
//
//  Created by Yerassyl Zhassuzakhov on 4/30/19.
//  Copyright © 2019 Yerassyl Zhassuzakhov. All rights reserved.
//

import Foundation

protocol Parser {
    func parse<T: Decodable>(data: Data?, response: URLResponse?, error: Error?) -> Result<T>
}

class DefaultParserImpl: Parser {
    func parse<T>(data: Data?, response: URLResponse?, error: Error?) -> Result<T> where T : Decodable {
        if let error = error {
            return .failure(error.localizedDescription)
        }
        guard let response = response as? HTTPURLResponse else { return .failure("Response is not in HTTPResponse format") }
        switch response.statusCode {
        case 200...299:
            guard let data = data else { return .failure(NetworkResponse.noData.rawValue) }
            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode(T.self, from: data)
                return Result.success(result)
            } catch {
                return .failure(error.localizedDescription)
            }
        case 300...399:
            return .failure(NetworkResponse.redirect.rawValue)
        case 400...499:
            return .failure(NetworkResponse.authenticationError.rawValue)
        case 500...501:
            return .failure(NetworkResponse.badRequest.rawValue)
        case 600:
            return .failure(NetworkResponse.outdated.rawValue)
        default:
            return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
