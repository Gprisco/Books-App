//
//  ContentView.swift
//  Books App
//
//  Created by Giovanni Prisco on 29/09/2020.
//

import SwiftUI
import CoreData

// MARK: - Create and delete book functions
func createBook(_ context: NSManagedObjectContext) -> Void {
    let newBook = Book(context: context)
    
    newBook.id = UUID()
    newBook.createdAt = Date()
    newBook.updatedAt = newBook.createdAt
    newBook.title = "Hello there!"
    newBook.author = "I'm your new book"
    newBook.progress = 0.0
    
    do {
        try context.save()
    } catch {
        print(error.localizedDescription)
    }
}

func deleteBook(_ context: NSManagedObjectContext, indexSet: IndexSet, books: FetchedResults<Book>, filter: (_ book: Book) -> Bool) -> Void {
    for index in indexSet {
        context.delete(books.filter(filter)[index])
    }
    
    do {
        try context.save()
    } catch {
        print(error.localizedDescription)
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "updatedAt", ascending: false)],  animation: .default) private var books: FetchedResults<Book>
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: HStack {
                        Text("Current reading")
                        
                        Spacer()
                        
                        Button(action: {
                            createBook(viewContext)
                        }) {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.blue)
                                .clipped()
                                .scaledToFill()
                        }

                    }) {
                        ForEach(books.filter({ $0.progress < 1.0 })) { book in
                            BookCard(book: book, icon: "book")
                        }
                        .onDelete(perform: { indexSet in
                            deleteBook(viewContext, indexSet: indexSet, books: books, filter: { $0.progress < 1.0 })
                        })
                    }
                    
                    if books.filter({ $0.progress == 1.0 }).count > 0 {
                        Section(header: Text("Completed")) {
                            ForEach(books.filter({ $0.progress == 1.0 })) { book in
                                BookCard(book: book, icon: "book.fill")
                            }
                            .onDelete(perform: { indexSet in
                                deleteBook(viewContext, indexSet: indexSet, books: books, filter: { $0.progress == 1.0 })
                            })
                        }
                    }
                }
                .listStyle(GroupedListStyle())
            }
            .navigationTitle(Text("Books"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
