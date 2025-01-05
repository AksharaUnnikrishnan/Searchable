//
//  TaskData.swift
//  Searchable
//
//  Created by Akshara Unnikrishnan on 05/01/25.
//

import SwiftUI
import Observation

enum Scopes {
    case work
    case personal
}


struct Task: Identifiable, Hashable {
   let id = UUID()
   var title: String
   var description: String
   var dueDate: Date
   var category: String // e.g., "Work" or "Personal"
   var completed: Bool
   
   var displayDueDate: String {
      let formatter = DateFormatter()
      formatter.dateStyle = .medium
      return formatter.string(from: dueDate)
   }
}

@Observable class TaskData: @unchecked Sendable {
    @ObservationIgnored var taskData: [Task] {
        didSet {
            filteredValues(searchValue: "")
        }
    }
    
    var filteredItems: [Task] = []
    func filteredValues(searchValue: String, selectedScope: Scopes = .work) {
        let filteredCategory: [Task]
        switch selectedScope {
        case .work:
            filteredCategory = taskData.filter{$0.category == "Work"}
        case .personal:
            filteredCategory = taskData.filter{$0.category == "Personal"}
        }
        if searchValue.isEmpty {
            filteredItems = filteredCategory.sorted(by: { $0.title < $1.title})
        } else {
            let list = filteredCategory.filter{$0.title.localizedStandardContains(searchValue) || $0.description.localizedStandardContains(searchValue)}
            filteredItems = list.sorted(by: {$0.title < $1.title})
        }
        
    }
    
    static let shared: TaskData = TaskData()
    private init() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        taskData = [ 
                     Task(title: "Prepare presentation", description: "Work on the Q1 project presentation for the team.", dueDate: formatter.date(from: "2024/12/15")!, category: "Work", completed: false),
                     Task(title: "Grocery shopping", description: "Buy groceries for the week.", dueDate: formatter.date(from: "2024/12/10")!, category: "Personal", completed: false),
                     Task(title: "Submit report", description: "Finalize and submit the annual report.", dueDate: formatter.date(from: "2024/12/14")!, category: "Work", completed: false),
                     Task(title: "Doctor's appointment", description: "Annual health check-up.", dueDate: formatter.date(from: "2024/12/12")!, category: "Personal", completed: false),
                     Task(title: "Team meeting", description: "Discuss project updates with the team.", dueDate: formatter.date(from: "2024/12/11")!, category: "Work", completed: false),
                     Task(title: "Read a book", description: "Finish reading the latest novel.", dueDate: formatter.date(from: "2024/12/20")!, category: "Personal", completed: false),
                     Task(title: "Plan vacation", description: "Research and book tickets for the holiday.", dueDate: formatter.date(from: "2024/12/18")!, category: "Personal", completed: false),
                     Task(title: "Update resume", description: "Revise resume for new job opportunities.", dueDate: formatter.date(from: "2024/12/16")!, category: "Work", completed: false),
                     Task(title: "Organize files", description: "Organize work files and folders for easy access.", dueDate: formatter.date(from: "2024/12/09")!, category: "Work", completed: false),
                     Task(title: "Prepare dinner party", description: "Plan and prepare for the weekend dinner party.", dueDate: formatter.date(from: "2024/12/13")!, category: "Personal", completed: false),
                     Task(title: "Fix plumbing issue", description: "Call a plumber to fix the leaking kitchen sink.", dueDate: formatter.date(from: "2024/12/14")!, category: "Personal", completed: false),
                     Task(title: "Complete online course", description: "Finish the advanced SwiftUI course by the end of the month.", dueDate: formatter.date(from: "2024/12/22")!, category: "Work", completed: false),
                     Task(title: "Visit parents", description: "Spend the weekend with parents.", dueDate: formatter.date(from: "2024/12/17")!, category: "Personal", completed: false),
                     Task(title: "Finish project prototype", description: "Complete the initial prototype for the new app.", dueDate: formatter.date(from: "2024/12/19")!, category: "Work", completed: false),
                     Task(title: "Christmas shopping", description: "Buy Christmas gifts for family and friends.", dueDate: formatter.date(from: "2024/12/21")!, category: "Personal", completed: false),
                     Task(title: "Car service", description: "Take the car for a scheduled maintenance service.", dueDate: formatter.date(from: "2024/12/14")!, category: "Personal", completed: false),
                     Task(title: "Plan Q1 strategy", description: "Draft a strategic plan for Q1 objectives.", dueDate: formatter.date(from: "2024/12/23")!, category: "Work", completed: false),
                     Task(title: "Call bank", description: "Resolve account issues with the bank.", dueDate: formatter.date(from: "2024/12/10")!, category: "Personal", completed: false),
                     Task(title: "Holiday decoration", description: "Decorate the house for the holiday season.", dueDate: formatter.date(from: "2024/12/20")!, category: "Personal", completed: false),
                     Task(title: "Prepare tax documents", description: "Organize and prepare tax documents for submission.", dueDate: formatter.date(from: "2024/12/15")!, category: "Work", completed: false)
        ]
        filteredValues(searchValue: "")
    }
}



