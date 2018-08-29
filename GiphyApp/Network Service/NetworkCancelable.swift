//
//  NetworkCancelable.swift
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/28/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import Foundation

@objc protocol NetworkCancelable {
    @objc func cancel()
}

@objc extension URLSessionDataTask: NetworkCancelable { }
