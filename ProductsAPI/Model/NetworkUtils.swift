//
//  NetworkUtils.swift
//  ProductsAPI
//
//  Created by Shayan Amini on 08/10/2023.
//

import Foundation

enum NetworkResult<T: Codable> {
    case success(T)
    case failure(Error)
}

enum NetworkError: Error {
    case badUrl
    case badResponse
}

extension NetworkError {
    var errorDescription: String? {
        switch self {
        case .badUrl:
            "URL is not valid"
        case .badResponse:
            "Bad response"
        }
    }
}
