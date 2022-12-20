//
//  StringLocalization.swift
//  
//
//  Created by Enrico Irawan on 20/12/22.
//

import Foundation

extension String {
  public func localized() -> String {
    let bundle = Bundle(identifier: "com.enrico.Weabopedia-Modular") ?? .main
    return bundle.localizedString(forKey: self, value: nil, table: nil)
  }
}
