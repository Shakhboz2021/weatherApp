//
//  BundleExtensions.swift
//  Weather
//
//  Created by Shakhboz Tokhirov on 06/10/22.
//

import Foundation

extension Bundle {
    private static var bundle: Bundle!
    
    static func localizedBundle() -> Bundle! {
        if bundle == nil {
            let appLang = UDManager.shared.currentLanguageKey
            let path = Bundle.main.path(forResource: appLang, ofType: "lproj")
            bundle = Bundle(path: path!)
        }
        
        return bundle
    }
    
    static func setAppLanguage(lan: String) {
        UDManager.shared.setCurrentLanguageKey(lan)
        let path = Bundle.main.path(forResource: lan, ofType: "lproj")
        bundle = Bundle(path: path!)
    }
}
