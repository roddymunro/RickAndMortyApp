//
//  APIError.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-18.
//

import Foundation

enum APIError: Error {
    case invalidResponse
    case decodingError
    case invalidUrl
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return NSLocalizedString(
                "errors.APIError.invalidResponse",
                comment: "The error message given when APIError.invalidResponse is thrown."
            )
        case .decodingError:
            return NSLocalizedString(
                "errors.APIError.decodingError",
                comment: "The error message given when APIError.decodingError is thrown."
            )
        case .invalidUrl:
            return NSLocalizedString(
                "errors.APIError.invalidUrl",
                comment: "The error message given when APIError.invalidUrl is thrown."
            )
        }
    }
}

