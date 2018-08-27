//
//  APITypes.swift
//  GiphyApp
//
//  Created by Алексей on 26.08.2018.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]

enum APIResult<T> {
    case Failure(APIErrorType)
    case Success(T)
}

enum APIErrorType {
    case NoDataReturned
    case InvalidDataFormat
    case ConnectionFailed(Error)
    
    var description: String {
        switch self {
        case .NoDataReturned:
            return "No data returned"
        case .InvalidDataFormat:
            return "Parsing was failed"
        case .ConnectionFailed(let error):
            return "Connection failed: \(error.localizedDescription)"
        }
    }
}

enum APIRequestType: String {
    case trending = "trending"
    case search = "search"
}
