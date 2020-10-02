//
//  BookCard.swift
//  Books App
//
//  Created by Giovanni Prisco on 29/09/2020.
//

import SwiftUI

struct BookCard: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var book: Book
    let icon: String
    
    @State var showBookSheet = false
    
    var body: some View {
        NavigationLink(destination: BookDetails(book: book)) {
            HStack(alignment: .center) {
                Image(systemName: icon)
                    .padding()
                
                VStack(alignment: .leading) {
                    Text(book.title).font(.headline).lineLimit(1)
                    Text(book.author).font(.subheadline).lineLimit(1)
                }
                
                Spacer()
                
                ProgressCircleBar(progress: book.progress)
            }
        }
    }
}

struct BookCard_Previews: PreviewProvider {
    static func getBook(title: String, author: String, progress: Double, notes: String?) -> Book {
        let book = Book(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
        
        book.title = title
        book.author = author
        book.progress = progress
        book.notes = notes ?? ""
        
        return book
    }
    
    static var previews: some View {
        BookCard(book: getBook(title: "What to do when things fall apart", author: "Pema Chödrön", progress: 0.4, notes: nil), icon: "book.fill")
    }
}
