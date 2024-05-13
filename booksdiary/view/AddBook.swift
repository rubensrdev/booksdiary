//
//  AddBook.swift
//  booksdiary
//
//  Created by Ruben on 9/5/24.
//

import SwiftUI
import SwiftData

struct AddBook: View {
    
    @Environment(\.modelContext) private var modelContext
    @Binding var isShowingBookSheet: Bool
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var isFavorite: Bool = false
    @State private var isRead: Bool = false
    @State private var review: String = ""
    
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Book data").bold()) {
                    
                    TextField("Title", text: $title)
                    TextField("Author", text: $author)
                        .disabled(title.isEmpty)
                    Toggle("Fav", isOn: $isFavorite)
                        .disabled(title.isEmpty)
                    Toggle("Is read", isOn: $isRead)
                        .disabled(title.isEmpty)
                    TextEditor(text: $review)
                        .frame(minHeight: 200)
                        .disabled(!isRead)
                    
                    Button(action: { saveBook() }) {
                        Text("Save book")
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical)
                    .disabled(title.isEmpty)
                    .buttonStyle(.borderedProminent)
                }
            }
        }
    }
    
    func saveBook() {
        let metadata =  Metadata(isFavorite: isFavorite, isRead: isRead, review: review)
        let book = Book(id: .init(), title: title, author: author, metadata: metadata)
        modelContext.insert(book)
        goToHome()
    }
    
    func goToHome() {
        isShowingBookSheet = false
    }
    
}

/*
#Preview {
    AddBook()
}*/
