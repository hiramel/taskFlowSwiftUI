//
//  TasksListView.swift
//  TaskFlow
//
//  Created by Hiram Elguézabal Jiménez on 18/06/26.
//

import SwiftUI

struct TasksListView: View {
    
    let viewModel: TasksListViewModel
    
    var body: some View {
        content
            .navigationTitle("Tasks")
            .task {
                await viewModel.loadTasks()
            }
    }
    
    private var content: some View {
        List {
            ForEach(viewModel.tasks) { task in
                Text(task.title)
            }
        }
    }
}

#Preview {
    //TasksListView()
}
