//
//  File.swift
//  
//
//  Created by DeGao on 2022/6/24.
//

import Fluent

struct CreateGalaxy: AsyncMigration {
    func revert(on database: Database) async throws {
        try await database.schema(Galaxy.schema).delete()
    }
    
    
    func prepare(on database: Database) async throws {
        try await database.schema(Galaxy.schema)
            .id()
            .field(Galaxy.name, .string)
            .create()
    }
    
    
}

