//
//  File.swift
//  
//
//  Created by DeGao on 2022/6/24.
//

import Fluent
import Foundation

// It's recommended to mark model classes final to improve performance and simplify conformance requirements.
final class Galaxy: Model {
//  table name. The schema is usually snake_case and plural. plural(复数)
    static let schema = "galaxies"
    static let name: FieldKey = "name"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: Galaxy.name)
    var name: String
    
    // all models require an empty init. This allows Fluent to create new instances of the model.
    init() {}
    
    init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }
    
}
