import Vapor
import Fluent

func routes(_ app: Application) throws {

    app.group("article") { article in
        article.get(":title") { req async throws -> AnyAsyncResponse in
            guard let title = req.parameters.get("title") else {
                return AnyAsyncResponse("wrong title")
            }
            
            guard let article = try await Article.query(on: req.db)
                    .filter(\.$title == title)
                    .first()
            else {
                return AnyAsyncResponse("no such article")
            }
            
            return AnyAsyncResponse(article)
        }
        
        article.post { req async throws -> String in
            let article = try req.content.decode(Article.self)
            try await article.create(on: req.db)
            return "success"
        }
    }
    
    app.group("articles") { articles in
        articles.get { req in
            try await Article.query(on: req.db).all()
        }

        articles.post { req async throws -> String in
            let articles = try req.content.decode(Array<Article>.self)
            try await articles.create(on: req.db)
            return "success"
        }
    }
}

//app.post("stars") { req -> AnyAsyncResponse in
//    guard let galaxy = try await Galaxy.query(on: req.db).first(),
//          let jsonData = req.body.string?.data(using: .utf8),
//          let jsonObject = try JSONSerialization.jsonObject(with: jsonData) as? [String : String],
//          let starName = jsonObject["name"]
//    else {
//        return AnyAsyncResponse("error")
//    }
//    let star = Star(name: starName, galaxyID: galaxy.id!)
//    try await star.create(on: req.db)
//    return await AnyAsyncResponse(try star.encodeResponse(for: req))
//}
