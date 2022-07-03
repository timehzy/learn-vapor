import Vapor
import Foundation
import Fluent
import FluentPostgresDriver
import Leaf

public func configure(_ app: Application) throws {
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    app.routes.caseInsensitive = true
    try routes(app)

    app.databases.use(.postgres(hostname: "server1.navicat.com", username: "navicat", password: "testnavicat", database: "HR"), as: .psql)
    
    app.migrations.add([CreateArticle(), CreateTag()])
//    try app.autoMigrate().wait()
    
    app.views.use(.leaf)
    app.leaf.tags["now"] = NowTag()
    otherConfigure(app)
}

func otherConfigure(_ app: Application) {
    // 自定义json编码
    //    app.routes.defaultMaxBodySize = "500kb"
    //    let encoder = JSONEncoder()
    //    encoder.dateEncodingStrategy = .secondsSince1970
    //    ContentConfiguration.global.use(encoder: encoder, for: .json)
}
