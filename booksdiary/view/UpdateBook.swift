//
//  UpdateBook.swift
//  booksdiary
//
//  Created by Ruben on 9/5/24.
//

import SwiftUI

struct UpdateBook: View {
    
    @Bindable var book: Book
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Update book data").bold()) {
                    TextField("title", text: $book.title)
                    TextField("Author", text: $book.author)
                    Toggle("Favorite", isOn: $book.metadata.isFavorite)
                    Toggle("Is Read", isOn: $book.metadata.isRead)
                    TextEditor(text: $book.metadata.review)
                        .frame(minHeight: 200)
                }
            }
        }
    }
}

#Preview {
    UpdateBook(book: .init(id: .init(), title: "book to update", author: "book author", metadata: .init(isFavorite: false, isRead: false, review: "NA")))
}
