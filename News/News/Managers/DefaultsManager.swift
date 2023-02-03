//
//  DefaultsManager.swift
//  News
//
//  Created by VladVarsotski on 2.02.23.
//

import Foundation

class DefaultsManager {
    private static let defaults = UserDefaults.standard
    
    static var countViews: Int {
        get {
            return defaults.value(forKey: #function) as? Int ?? 0
        }
        set {
            defaults.set(newValue, forKey: #function)
        }
    }
}
