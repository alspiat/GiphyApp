//
//  SettingsViewModel.swift
//  GiphyApp
//
//  Created by Aliaksei Piatyha on 8/31/18.
//  Copyright © 2018 Aliaksei Piatyha. All rights reserved.
//

import Foundation

@objcMembers class SettingsViewModel: NSObject {
    
    class func kSettingsRatingPicker() -> String {
        return "rating"
    }
    
    var ratingItems = ["y", "g", "pg", "pg-13", "r", "nsfw", "unrated"]
    var currentRating: String?
    
    override init() {
        super.init()
        if let rating = self.ratingFromUserDefaults() {
            currentRating = rating
        } else {
            currentRating = ratingItems.last
        }
    }
    
    public var didUpdate: (() -> Void) = {}
    
    var userDefaults: UserDefaults {
        return UserDefaults.standard
    }
    
    func saveRatingToUserDefaults() {
        if let rating = self.currentRating {
            userDefaults.set(rating, forKey: SettingsViewModel.kSettingsRatingPicker())
            userDefaults.synchronize()
        }
    }
    
    func ratingFromUserDefaults() -> String? {
        return userDefaults.object(forKey: SettingsViewModel.kSettingsRatingPicker()) as? String
    }
    
    func setCurrentRating(index: Int) {
        if index < self.ratingItems.count {
            self.currentRating = self.ratingItems[index]
        }
    }
}
