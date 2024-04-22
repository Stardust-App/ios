//
//  RowndStorage.swift
//  ios native
//
//  Created by Matt Hamann on 6/15/22.
//

import Foundation

struct Storage {
    private init(){}
    
    // Deprecated don't use anymore
    static var legacyStore = UserDefaults.init(suiteName: "io.rownd.sdk")
    
    static var store = UserDefaults.init(suiteName: "group.io.rownd.sdk")
    
    static func migrateKeyIfExists() {
        if let key = Storage.legacyStore?.object(forKey: STORAGE_STATE_KEY) {
            Storage.store?.set(key, forKey: STORAGE_STATE_KEY)
            Storage.legacyStore?.set(nil, forKey: STORAGE_STATE_KEY)
        }
    }
}
