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
    
    var userDefaults: UserDefaults {
        return UserDefaults.standard
    }
    
    func saveRatingToUserDefaults(rating: String) {
        userDefaults.set(rating, forKey: SettingsViewModel.kSettingsRatingPicker())
        userDefaults.synchronize()
    }
    
    func ratingFromUserDefaults() -> String? {
        return userDefaults.object(forKey: SettingsViewModel.kSettingsRatingPicker()) as? String
    }
}
