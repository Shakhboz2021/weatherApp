//
//  UDManager.swift
//  Weather
//
//  Created by Shakhboz Tokhirov on 06/10/22.
//

import Foundation

class UDManager {
    static var shared = UDManager()
    
    var currentLanguageKey: String {
        return UserDefaults.standard.string(forKey: UDManagerConstants.languageKey) ?? "en"
    }
    
    func setCurrentLanguageKey(_ languageKey: String) {
        UserDefaults.standard.setValue(languageKey, forKey: UDManagerConstants.languageKey)
    }
    
    func clear() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
}
