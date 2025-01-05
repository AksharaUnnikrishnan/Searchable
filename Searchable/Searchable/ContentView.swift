//
//  ContentView.swift
//  Searchable
//
//  Created by Akshara Unnikrishnan on 05/01/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(TaskData.self) private var appData
    @State private var searchTerm: String = ""
    @State private var searchScope: Scopes = .work
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(appData.filteredItems) { task in
                    TaskCell(task: task)
                }
                .onDelete(perform: deleteTask)
            }
            .navigationTitle(Text("Tasks"))
        }
        .searchable(text: $searchTerm, prompt: Text("Search tasks"))
        .searchScopes($searchScope, scopes: {
            Text("Work").tag(Scopes.work)
            Text("Personal").tag(Scopes.personal)
        })
//        .onChange(of: searchTerm, initial: false) { _, _ in
//            performSearch()
//        }
        .onChange(of: searchScope) { _, _ in
            performSearch()
        }
    }
    
    private func deleteTask(at offsets: IndexSet) {
        // Find the items to delete in the original `userData`
        let tasksToDelete = offsets.map { appData.filteredItems[$0] }
        for task in tasksToDelete {
            if let index = appData.taskData.firstIndex(of: task) {
                appData.taskData.remove(at: index)
            }
        }
    }
    
    func performSearch() {
        let search = searchTerm.trimmingCharacters(in: .whitespaces)
        appData.filteredValues(searchValue: search, selectedScope: searchScope)
    }
}

struct TaskCell: View {
    let task: Task
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(task.title)
                .font(.headline)
                .bold()
            Text(task.description)
                .font(.subheadline)
                .foregroundColor(.gray)
                .lineLimit(2)
            Text("Due: \(task.displayDueDate)")
                .font(.caption)
                .foregroundColor(.primary)
                .fontWeight(.semibold)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    ContentView()
        .environment(TaskData.shared)
}

