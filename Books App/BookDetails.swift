//
//  BookDetails.swift
//  Books App
//
//  Created by Giovanni Prisco on 29/09/2020.
//

import SwiftUI
import Combine
import CoreData

let placeholder = "Your thoughts here..."

final class BookDetailsData: ObservableObject {
    var book: Book
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var bookTitle: String {
        didSet {
            publishUpdates()
        }
    }
    
    var bookAuthor: String {
        didSet {
            publishUpdates()
        }
    }
    
    var progress: Double {
        didSet {
            publishUpdates()
        }
    }
    
    var notes: String {
        didSet {
            publishUpdates()
        }
    }
    
    init(book: Book) {
        self.book = book
        
        bookTitle = book.title
        bookAuthor = book.author
        progress = book.progress
        notes = book.notes
    }
    
    func publishUpdates() {
        book.title = bookTitle
        book.author = bookAuthor
        book.progress = progress
        book.notes = notes
        book.updatedAt = Date()
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct BookDetails: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var bookData: BookDetailsData
    
    init(book: Book) {
        self.bookData = BookDetailsData(book: book)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "book")
                .padding()
            
            Form {
                Section(header: Text("Book Info")) {
                    TextField("Book Title", text: $bookData.bookTitle)
                    TextField("Book Author", text: $bookData.bookAuthor)
                }
                
                Section(header: Text("Book Progress")) {
                    Slider(value: $bookData.progress, in: 0...1)
                }
                
                Section(header: Text("Notes")) {
                    TextEditor(text: $bookData.notes).onTapGesture(perform: {
                        if(bookData.notes == placeholder) {
                            bookData.notes = ""
                        }
                    })
                }
            }
        }
        .navigationTitle(Text("Update your read"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BookDetails_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let book = Book(context: context)
        book.id = UUID()
        
        return BookDetails(book: book)
    }
}
