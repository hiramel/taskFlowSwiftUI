//
//  TasksListView.swift
//  TaskFlow
//
//  Created by Hiram Elguézabal Jiménez on 18/06/26.
//

import SwiftUI

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

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView("Loading Tasks")

        case .loaded(let tasks):
            List {
                ForEach(tasks) { task in
                    Text(task.title)
                }
            }

        case .failed(let message):
            ContentUnavailableView(
                "No se pudieron cargar las tasks",
                systemImage: "exclamationmark.triangle",
                description: Text(message)
            )
        }
    }
}

#Preview {
    //TasksListView()
}
