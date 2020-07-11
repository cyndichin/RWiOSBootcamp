//
//  ContentView.swift
//  TaskList
//
//  Created by cynber on 7/9/20.
//  Copyright © 2020 cyndichin. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var taskStore: TaskStore
    @State var modalIsPresented = false
    var body: some View {
//        List(taskStore.tasks.indices) { index in
//            Text(self.taskStore.tasks[index].name)
//        }
        NavigationView {
            List {
                // remove taskStore.tasks.indices originally used for dependency injection, task bindings; used extensions
                ForEach(taskStore.prioritizedTasks) { index in
                    SectionView(prioritizedTasks: self.$taskStore.prioritizedTasks[index])
                }
            }
        .listStyle(GroupedListStyle())
            
        .navigationBarTitle("Tasks")
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                Button(action: {
                    self.modalIsPresented = true
                }) {
                Image(systemName: "plus")
                }
            )
        }
        .sheet(isPresented: $modalIsPresented) {
            NewTaskView(taskStore: self.taskStore)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(taskStore: TaskStore())
    }
}
