//
//  APIParsing.swift
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/28/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]

protocol JSONDecodable {
    init?(JSON: JSON)
}
