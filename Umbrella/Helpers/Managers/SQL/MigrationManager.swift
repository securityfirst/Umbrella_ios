//
//  MigrationManager.swift
//  Umbrella
//
//  Created by Lucas Correa on 30/05/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation
import SQLite

class MigrationManager {
    let sqliteMigrationManager: SQLiteMigrationManager

    init(sqlManager: SQLManager) {
        self.sqliteMigrationManager = SQLiteMigrationManager(db: sqlManager.openConnection()!, bundle: MigrationManager.migrationsBundle())
    }
    
    func migrateIfNeeded() throws {
        if !sqliteMigrationManager.hasMigrationsTable() {
            try sqliteMigrationManager.createMigrationsTable()
        }

        if sqliteMigrationManager.needsMigration() {
            try sqliteMigrationManager.migrateDatabase()
        }
    }
    
    func skipAllMigration() throws {
        if !sqliteMigrationManager.hasMigrationsTable() {
            try sqliteMigrationManager.createMigrationsTable()
        }
        
        try sqliteMigrationManager.skipAllMigrations()
    }
    
    static func migrationsBundle() -> Bundle {
        guard let bundleURL = Bundle.main.url(forResource: "Migrations", withExtension: "bundle") else {
            fatalError("could not find migrations bundle")
        }
        guard let bundle = Bundle(url: bundleURL) else {
            fatalError("could not load migrations bundle")
        }
        
        return bundle
    }
    
}
