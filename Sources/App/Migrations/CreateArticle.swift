//
//  CreateArticle.swift
//  
//
//  Created by 郝振壹 on 2022/6/26.
//

import Fluent

struct CreateArticle: AsyncMigration {
    
    func prepare(on database: Database) async throws {
        try await database.schema(Article.schema)
            .id()
            .field(Article.titleKey, .string)
            .field(Article.contentKey, .string)
            .field(Article.creationDateKey, .date)
            .field(Article.updateDateKey, .date)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema(Article.schema).delete()
    }
}

struct CreateTag: AsyncMigration {
    
    func prepare(on database: Database) async throws {
        try await database.schema(Tag.schema)
            .id()
            .field(Tag.nameKey, .string)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema(Tag.schema).delete()
    }
}
