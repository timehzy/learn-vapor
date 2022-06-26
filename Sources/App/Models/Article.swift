//
//  File.swift
//  
//
//  Created by 郝振壹 on 2022/6/26.
//

import Vapor
import FluentKit

final class Article: Model, Content {
    static let schema = "articles"
    static let titleKey: FieldKey = "title"
    static let creationDateKey: FieldKey = "creation_date"
    static let updateDateKey: FieldKey = "update_date"
    static let contentKey: FieldKey = "content"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: Article.titleKey)
    var title: String
    
    @Timestamp(key: Article.creationDateKey, on: .create)
    var creationDate: Date?
    
    @Timestamp(key: Article.creationDateKey, on: .update)
    var updateDate: Date?
    
    @Field(key: Article.contentKey)
    var content: String
    
    @Siblings(through: ArticleTag.self, from: \.$article, to: \.$tag)
    var tags: [Tag]
}


final class Tag: Content, Model {
    static let schema = "tags"
    static let nameKey: FieldKey = "name"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: Tag.nameKey)
    var name: String
    
    @Siblings(through: ArticleTag.self, from: \.$tag, to: \.$article)
    var articles: [Article]
}


final class ArticleTag: Model {
    
    static let schema = "aritcle+tag"
    static let articleId: FieldKey = "article_id"
    static let tagId: FieldKey = "tag_id"

    @ID(key: .id)
    var id: UUID?

    @Parent(key: ArticleTag.articleId)
    var article: Article

    @Parent(key: ArticleTag.tagId)
    var tag: Tag

    init() { }

    init(id: UUID? = nil, article: Article, tag: Tag) throws {
        self.id = id
        self.$article.id = try article.requireID()
        self.$tag.id = try tag.requireID()
    }
}
