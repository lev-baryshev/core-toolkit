//
//  ResourcesString.swift
//  CoreToolkit
//
//  Created by sugarbaron on 03.04.2023.
//

import Foundation

// MARK: constructor
public extension Resources {
    
    struct String {
        
        public let key:     Swift.String
        public let catalog: Swift.String
        
        public init(_ key: Swift.String, _ catalog: Swift.String = "Localizable") {
            self.key = key
            self.catalog = catalog
        }
        
    }
    
}

public extension String {
    
    var stringResource: Resources.String {
        .init(self)
    }
    
    func stringResource(catalog: String) -> Resources.String {
        .init(self, catalog)
    }
    
}
    
// MARK: interface
public extension Resources.String {
    
    var string: String {
        translate(key, of: catalog)
    }
    
    func quantified(_ items: Int) -> String {
        let items: Int = items % 100
        let quantified: String? = if items.isOne(of: 11..<15) {
            find(quantified(.many).key, in: catalog)
        } else {
            switch items % 10 {
            case 1:       find(quantified(.one).key,  in: catalog)
            case 2, 3, 4: find(quantified(.few).key,  in: catalog)
            default:      find(quantified(.many).key, in: catalog)
            }
        }
        let template: String = quantified ?? translate(key, of: catalog)
        return template.contains("%d")
                    ? String(format: template, items)
                    : template
    }
    
    func quantified(_ quantification: Quantification) -> Resources.String {
        switch quantification {
        case .one:  "\(key)_one".stringResource
        case .few:  "\(key)_few".stringResource
        case .many: "\(key)_many".stringResource
        }
    }
    
    enum Quantification {
        case one
        case few
        case many
    }
        
}

extension Resources.String : Equatable {
    
    public static func ==(lhs: Resources.String, rhs: Resources.String) -> Bool {
        lhs.key == rhs.key
    }
    
}

// MARK: tools
private extension Resources.String {
    
    func find(_ key: String, in catalog: String) -> String? {
        let translation: String = translate(key, of: catalog)
        return (translation == key) ? nil : translation
    }
    
    func translate(_ key: String, of catalog: String) -> String {
        guard key.isNotEmpty else { return "" }
        let language: String = Locale.currentLanguageName
        let translation: String = translate(key, of: catalog, in: language)
        let ok: Bool = (translation != key)
        return ok ? translation : translate(key, of: catalog, in: english)
    }
    
    func translate(
        _ key: String,
        of catalog: String,
        in language: String
    ) -> String {
        guard let path: String = Bundle.main.path(forResource: language, ofType: "lproj"),
              let targetBundle: Bundle = .init(path: path)
        else { return key }
        return NSLocalizedString(key, tableName: catalog, bundle: targetBundle, comment: "")
    }
    
    var english: String { "en" }
    
}
