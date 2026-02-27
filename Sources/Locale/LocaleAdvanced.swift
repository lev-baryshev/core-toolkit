//
//  LocaleAdvanced.swift
//  CoreToolkit
//
//  Created by sugarbaron on 08.05.2020.
//

import Foundation

// MARK: interface
public extension Locale {
    
    static var currentLanguage: Locale? {
        .init(identifier: currentLanguageName)
    }
    
    /**
     * we can not use `Locale.current` because it can be differ than language set by user on device
     **/
    static var currentLanguageName: String {
        if let preferred: String = UserDefaults.standard.array(forKey: "AppleLanguages")?.first as? String {
            cutRegion(preferred)
        } else {
            Language.en.name
        }
    }
    
    internal enum Language : String {
        case en = "en"
        case ru = "ru"
        case es = "es"
        
        internal init(_ name: String) {
            self = Language(rawValue: name) ?? Language.en
        }
        
        internal var name: String { rawValue }
        
    }
    
}

// MARK: tools
private extension Locale {
    
    // cutting region: zh-Hans-RU -> zh-Hans, fr-RU -> fr
    private static func cutRegion(_ language: String) -> String {
        if language.isOne(of: dashed) { return language }
        var parts: [String] = language.split(with: "-")
        if parts.count < 2 { return language }
        parts = parts.dropLast()
        return parts.joined(by: "-")
    }
    
    // add here new dashed locales when they will appear
    static var dashed: [String] = [
        "pl-PL",
        "pt-BR",
        "ro-RO",
        "sr-Latn",
        "zh-Hans",
        "zh-HK"
    ]
    
}
