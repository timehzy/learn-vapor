import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }
    
    app.get("hello", ":name") { req -> String in
        let name = req.parameters.get("name") ?? "no params"
        return "hello, \(name)!!"
    }
    
    // 针对个别路径制定body size限制
    app.on(.POST, "xxx", body: .collect(maxSize: "1mb")) { req in
        HTTPStatus.ok
    }
    
    // 针对上传文件，使用流来接收body
    app.on(.POST, "upload", body: .stream) { req -> String in
//        在使用流的情况下，req.body.data 的值为nil，必须使用下面这种方式接收数据
//        req.body.drain { streamResult in
//            switch streamResult {
//            case .buffer(let byteBuffer):
//                print(byteBuffer)
//            case .error(let error):
//                print(error)
//            case .end:
//                print("upload end")
//            }
//            return .
//        }
        return "upload"
    }
    
    // 使用组来组织一组由共同前缀构成的路由
    app.group("user") { user in
        user.get { req in
            req.redirect(to: "hello", type: .normal)
        }
        user.post { req in
            "user post"
        }
    }

}
