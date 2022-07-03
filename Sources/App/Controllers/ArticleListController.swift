//
//  ArticleListController.swift
//  
//
//  Created by 郝振壹 on 2022/7/3.
//

import Foundation
import Vapor

struct ArticleListController {
    
    let req: Request
    
    let template = "ArticleListPage"
    
    func render() async throws -> View {
        try await req.view.render(template, ArticleListPage(title: "Moco的博客", articles: Article.query(on: req.db).all()))
    }
}

extension ArticleListController {
    
    struct ArticleListPage: Encodable {
        var title: String
        var articles: [Article]
    }
}
