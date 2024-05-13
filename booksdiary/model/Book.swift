//
//  Book.swift
//  booksdiary
//
//  Created by Ruben on 9/5/24.
//

import Foundation
import SwiftData

@Model
class Book {
    
    @Attribute(.unique) var id: UUID
    var title: String
    var author: String
    @Relationship(deleteRule: .cascade)
    var metadata: Metadata
    
    init(id: UUID, title: String, author: String, metadata: Metadata) {
        self.id = id
        self.title = title
        self.author = author
        self.metadata = metadata
    }
}
