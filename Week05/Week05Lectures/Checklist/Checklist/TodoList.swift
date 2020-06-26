//
//  TodoList.swift
//  Checklist
//
//  Created by cynber on 6/23/20.
//  Copyright © 2020 cyndichin. All rights reserved.
//

import Foundation

class TodoList {
    enum Priority: Int, CaseIterable {
        case high, medium, low, no
    }
    private var highPriorityTodos: [ChecklistItem] = []
    private var medPriorityTodos: [ChecklistItem] = []
    private var lowPriorityTodos: [ChecklistItem] = []
    private var noPriorityTodos: [ChecklistItem] = []
    
    init() {
        let row0Item = ChecklistItem()
        let row1Item = ChecklistItem()
        let row2Item = ChecklistItem()
        let row3Item = ChecklistItem()
        let row4Item = ChecklistItem()
         
        row0Item.text = "Take a jog"
        row1Item.text = "Watch a Movie"
        row2Item.text = "Code an App"
        row3Item.text = "Walk the Dog"
        row4Item.text = "Study Design Patterns"
        
        addTodo(row0Item, for: .medium)
        addTodo(row1Item, for: .low)
        addTodo(row2Item, for: .high)
        addTodo(row3Item, for: .no)
        addTodo(row4Item, for: .medium)
    }
    
    func addTodo(_ item: ChecklistItem, for priority: Priority, at index: Int = -1) {
        switch priority {
          case .high:
            if index < 0 {
                highPriorityTodos.append(item)
            } else {
                highPriorityTodos.insert(item, at: index)
            }
          case .medium:
            if index < 0 {
               medPriorityTodos.append(item)
           } else {
               medPriorityTodos.insert(item, at: index)
           }
          case .low:
            lowPriorityTodos.append(item)
            if index < 0 {
              lowPriorityTodos.append(item)
          } else {
              lowPriorityTodos.insert(item, at: index)
          }
          case .no:
            if index < 0 {
              noPriorityTodos.append(item)
          } else {
              noPriorityTodos.insert(item, at: index)
          }
          }
    }
    
    func todoList(for priority: Priority) -> [ChecklistItem] {
        switch priority {
        case .high:
            return highPriorityTodos
        case .medium:
            return medPriorityTodos
        case .low:
            return lowPriorityTodos
        case .no:
            return noPriorityTodos
        }
    }
    
    func newTodo() -> ChecklistItem {
        let item = ChecklistItem()
        item.text = randomTitle()
        item.checked = true
        // by default medium priority
        medPriorityTodos.append(item)
        return item
    }
    
    func move(item: ChecklistItem, from sourcePriority: Priority, at sourceIndex: Int, to destinationPriority: Priority, at destinationIndex: Int) {
        remove(item: item, from: sourcePriority, at: sourceIndex)
        addTodo(item, for: destinationPriority, at: destinationIndex)
    }
    
//    func move(item: ChecklistItem, to index: Int) {
////        guard let currentIndex = todos.firstIndex(of: item) else {
////            return
////        }
////        todos.remove(at: currentIndex)
////        todos.insert(item, at: index)
//    }
    
    func remove(item: ChecklistItem, from priority: Priority, at index: Int) {
        switch priority {
        case .high:
            highPriorityTodos.remove(at: index)
        case .medium:
            medPriorityTodos.remove(at: index)
        case .low:
            lowPriorityTodos.remove(at: index)
        case .no:
            noPriorityTodos.remove(at: index)
        }
    }
//    func remove(items: [ChecklistItem]) {
//        for item in items {
//            if let index = todos.firstIndex(of: item) {
//                todos.remove(at: index)
//            }
//        }
//    }
    private func randomTitle() -> String {
        let titles = ["New todo item", "Generic todo", "Fill me out", "I need something to do", "Much todo about nothing"]
        let randomNumber = Int.random(in: 0...titles.count - 1)
        return titles[randomNumber]
    }
}
