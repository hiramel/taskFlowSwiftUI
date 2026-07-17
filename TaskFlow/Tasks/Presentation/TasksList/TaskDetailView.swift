//
//  TaskDetailsView.swift
//  TaskFlow
//
//  Created by Hiram Elguézabal Jiménez on 23/06/26.
//

import SwiftUI

struct TaskDetailsView: View {
    @State private var task: Task
    let makeEditTaskViewModel: (Task) -> EditTaskViewModel
    let onSaved: () async -> Void

    @State private var isShowingEditTask = false
    
    init(
        task: Task,
        makeEditTaskViewModel: @escaping (Task) -> EditTaskViewModel,
        onSaved: @escaping () async -> Void
    ) {
        _task = State(initialValue: task)
        self.makeEditTaskViewModel = makeEditTaskViewModel
        self.onSaved = onSaved
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    header
                    dueDateRow
                    descriptionSection
                    categorySection
                    statusSection
                }
                .padding()
                .padding(.bottom, 16)
                .padding(.top, 8)
            }

            TaskButtonView(title: "Edit Task") {
                isShowingEditTask = true
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
            .padding(.top, 8)

        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // Acción futura
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
        .sheet(isPresented: $isShowingEditTask) {
            EditTaskView(
                viewModel: makeEditTaskViewModel(task)
            ) { updatedTask in
                task = updatedTask
                await onSaved()
            }
        }
    }
    
    private var header: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(task.title)
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .foregroundStyle(.primary)

            PillView(pillText: task.priority)
        }
    }
    
    private var dueDateRow: some View {
        HStack(spacing: 12) {
            Image(systemName: "calendar")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.secondary)
                .frame(width: 24)

            Text(task.dueDate)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundStyle(.primary)
        }
        .padding(.top, 4)
    }
    
    private var descriptionSection: some View {
         section(title: "Description") {
             Text(task.description)
                 .font(.system(size: 16, design: .rounded))
                 .foregroundStyle(.secondary)
                 .lineSpacing(4)
         }
     }
    
    private var categorySection: some View {
        section(title: "Category") {
            Text(task.category)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundStyle(.blue)
        }
    }

    private var statusSection: some View {
        section(title: "Status") {
            Text(task.status)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundStyle(.blue)
        }
    }

    
    private func section<Content: View>(
        title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundStyle(.primary)

            content()
        }
    }
}


#Preview {
    let repository = TasksRepositoryImpl(
        dataSource: PreviewTaskDataSource()
    )

    TaskDetailsView(
        task: Task(
            id: "1",
            title: "UI/UX Project",
            description: "Design the new mobile app screens and interaction flow for TaskFlow.",
            dueDate: "Due Today, 10:00 AM",
            category: "Work",
            priority: "High Priority",
            status: "0"
        ),
        makeEditTaskViewModel: { task in
            EditTaskViewModel(
                task: task,
                updateTaskUseCase: UpdateTaskUseCase(
                    taskRepository: repository
                )
            )
        },
        onSaved: { }
    )
}
