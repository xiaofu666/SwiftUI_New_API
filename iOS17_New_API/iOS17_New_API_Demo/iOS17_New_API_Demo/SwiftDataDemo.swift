//
//  SwiftDataDemo.swift
//  iOS17_New_API_Demo
//
//  Created by Lurich on 2023/6/11.
//

import SwiftUI
import SwiftData

struct SwiftDataDemo: View {
    @Environment(\.modelContext) private var ctx
    @Query(FetchDescriptor(
        predicate: #Predicate<Person> { $0.isLiked == true },
        sortBy: [SortDescriptor(\.dateAdded, order: .reverse)])
    ) private var favourites: [Person]
    @Query(FetchDescriptor(
        predicate: #Predicate<Person> { $0.isLiked == false },
        sortBy: [SortDescriptor(\.dateAdded, order: .reverse)])
    ) private var normals: [Person]
    
    var body: some View {
        List {
            createDisclosureGroup("Favourites", lists: favourites)
            
            createDisclosureGroup("Normals", lists: normals)
        }
        .navigationTitle("Swift Data")
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add Item") {
                    let person = Person(name: "Hello User \(Date().formatted(date: .numeric, time: .standard))")
                    ctx.insert(person)
                    
                    do {
                        try ctx.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        })
    }
    
    @ViewBuilder
    func createDisclosureGroup(_ name: String, lists: [Person]) -> some View {
        DisclosureGroup(name) {
            ForEach(lists) { personModel in
                HStack {
                    Text(personModel.name)
                    
                    Spacer()
                    
                    Button(action: {
                        personModel.isLiked.toggle()
                    }, label: {
                        Image(systemName: "suit.heart.fill")
                            .tint(personModel.isLiked ? .red : .gray)
                    })
                }
                .swipeActions() {
                    Button(action: {
                        ctx.delete(personModel)
                        try? ctx.save()
                    }, label: {
                        Image(systemName: "trash.fill")
                    })
                    .tint(.red)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SwiftDataDemo()
            .modelContainer(for: Person.self)
    }
}

@Model
class Person {
    var name: String
    var isLiked: Bool
    var dateAdded: Date
    
    init(name: String, isLiked: Bool = false, dateAdded: Date = .init()) {
        self.name = name
        self.isLiked = isLiked
        self.dateAdded = dateAdded
    }
}
