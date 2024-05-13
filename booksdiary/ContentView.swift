//
//  ContentView.swift
//  booksdiary
//
//  Created by Ruben on 8/5/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var books: [Book]
    
    @State var isShowingBookSheet = false

    var body: some View {
        NavigationStack { 
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text("\(book.title)")
                                if !book.author.isEmpty {
                                    Text("\(book.author)")
                                        .font(.footnote)
                                }
                            }
                            .padding(.leading, 15)
                            
                            if book.metadata.isFavorite {
                                Image(systemName: "star.fill")
                                    .foregroundStyle(.yellow)
                            }
                            if book.metadata.isRead {
                                Image(systemName: "book.closed.circle")
                                    .foregroundStyle(.green)
                            } else {
                                Image(systemName: "book.circle")
                                    .foregroundStyle(.red)
                            }
                            if book.metadata.isRead && (book.metadata.review == "NA" || book.metadata.review == "") {
                                Image(systemName: "pencil")
                                    .foregroundStyle(.orange)
                            }
                              
                        }
                    }
                }
                .onDelete(perform: deleteItems)

            }
            .navigationTitle("Books diary")
            .navigationDestination(for: Book.self, destination:  { book in
                UpdateBook(book: book)
            })
            .sheet(isPresented: $isShowingBookSheet, content: {
                AddBook(isShowingBookSheet: $isShowingBookSheet)
            })
            .toolbar {
                ToolbarItem {
                    Button(action: showBookSheet ) {
                        Label("Add book", systemImage: "plus")
                    }
                    .foregroundStyle(.red)
                    //.navigationDestination(isPresented: $toAddBookWiew, destination: { AddBook() })
                }
            }
            .overlay {
                if books.isEmpty {
                    ContentUnavailableView(
                        label: {
                            Label("No books", systemImage: "books.vertical")
                                .foregroundColor(.gray)
                        }, description: {
                                Text("You haven't added any books to the list yet.")
                        }, actions: {
                            Button(action: { showBookSheet() }, label: {
                                Text("Add book")
                            })
                            .foregroundStyle(.white)
                            .padding()
                            .background(.red)
                            .clipShape(Capsule())
                        })
                }
            }
            .tint(.red)
        }
    }

    private func showBookSheet() {
        isShowingBookSheet = true
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(books[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Book.self, inMemory: true)
}
