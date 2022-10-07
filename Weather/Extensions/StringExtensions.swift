//
//  String+extensions.swift
//  Weather
//
//  Created by Shakhboz Tokhirov on 05/10/22.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self,
                                 tableName: "Localizable",
                                 bundle: Bundle.localizedBundle(),
                                 value: self,
                                 comment: self
        )
    }
}
