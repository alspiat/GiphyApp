//
//  GifTypes.swift
//  GiphyApp
//
//  Created by Алексей on 26.08.2018.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import Foundation

@objc public enum GifRatingType: Int, RawRepresentable {
    case ratedY
    case ratedG
    case ratedPG
    case ratedPG13
    case ratedR
    case notSafeForWork
    case unrated
    
    public typealias RawValue = String
    
    public var rawValue: RawValue {
        switch self {
        case .ratedY:
            return "y"
        case .ratedG:
            return "g"
        case .ratedPG:
            return "pg"
        case .ratedPG13:
            return "pg-13"
        case .ratedR:
            return "r"
        case .notSafeForWork:
            return "nsfw"
        case .unrated:
            return "unrated"
        }
    }
    
    public init?(rawValue: RawValue) {
        switch rawValue.lowercased() {
        case "y":
            self = .ratedY
        case "g":
            self = .ratedG
        case "pg":
            self = .ratedPG
        case "pg-13":
            self = .ratedPG13
        case "r":
            self = .ratedR
        case "nsfw":
            self = .notSafeForWork
        case "unrated":
            self = .unrated
        default:
            self = .ratedR
        }
    }
    
}
