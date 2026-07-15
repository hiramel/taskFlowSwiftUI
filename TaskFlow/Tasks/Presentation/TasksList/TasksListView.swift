//
//  TasksListView.swift
//  TaskFlow
//
//  Created by Hiram Elguézabal Jiménez on 18/06/26.
//

import SwiftUI

struct TasksListView: View {
    let viewModel: TasksListViewModel
    let createTaskViewModel: CreateTaskViewModel

    @State private var selectedFilter: TaskListFilter = .all
    @State private var isShowingCreateTask = false

    var body: some View {
        ZStack {
            background

            content
        }
        .navigationTitle("My Tasks")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    // Acción futura
                } label: {
                    Image(systemName: "chevron.left")
                }
            }

            ToolbarItemGroup(placement: .topBarTrailing) {
                Button {
                    // Acción futura
                } label: {
                    Image(systemName: "magnifyingglass")
                }

                Button {
                    // Acción futura
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                }
            }
        }
        .task {
            await viewModel.loadTasks()
        }
        
        .sheet(isPresented: $isShowingCreateTask) {
            CreateTaskView(viewModel: createTaskViewModel){
                await viewModel.loadTasks()
            }
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            VStack {
                Spacer()
                ProgressView("Loading Tasks")
                Spacer()
            }

        case .loaded(let tasks):
            VStack(spacing: 0) {
                filterBar

                
                
                List {
                    ForEach(filteredTasks(tasks)) { task in
                        NavigationLink {
                            TaskDetailsView(task: task)
                        } label: {
                            TaskListRowView(task: task)
                        }
                        .buttonStyle(.plain)
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                delete(task)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .listRowInsets(
                            EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16)
                        )
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .contentMargins(.bottom, 110, for: .scrollContent)
                
                
                
                
            }
            .overlay(alignment: .bottomTrailing) {
                // aqui esta el fix
                floatingActionButton
                    .padding(.trailing, 18)
                    .padding(.bottom, 18)
            }

        case .failed(let message):
            ContentUnavailableView(
                "No se pudieron cargar las tasks",
                systemImage: "exclamationmark.triangle",
                description: Text(message)
            )
            .padding(.horizontal, 20)
        }
    }

    private var background: some View {
        Color(uiColor: .systemGroupedBackground)
            .ignoresSafeArea()
        .ignoresSafeArea()
    }

    private var filterBar: some View {
        HStack(spacing: 12) {
            ForEach(TaskListFilter.allCases) { filter in
                TaskFilterChip(
                    title: filter.title,
                    isSelected: selectedFilter == filter
                ) {
                    selectedFilter = filter
                }
            }
        }
        .frame(height:15)
        .padding(.horizontal, 16)
        .padding(.vertical, 25)
        .padding(.top, 12)
    }

    private var floatingActionButton: some View {
        Button {
            isShowingCreateTask = true
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 58, height: 58)
                .background(Color(red: 0.44, green: 0.24, blue: 0.82))
                .clipShape(Circle())
                .shadow(
                    color: Color(red: 0.44, green: 0.24, blue: 0.82).opacity(0.35),
                    radius: 12,
                    x: 0,
                    y: 6
                )
        }
    }

    private func filteredTasks(_ tasks: [Task]) -> [Task] {
        switch selectedFilter {
        case .all:
            return tasks
        case .pending:
            return tasks.filter { !taskIsCompleted($0) }
        case .completed:
            return tasks.filter(taskIsCompleted)
        }
    }

    private func taskIsCompleted(_ task: Task) -> Bool {
        let normalizedStatus = task.status
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        return normalizedStatus.contains("done") || normalizedStatus.contains("completed")
    }
    
    private func delete(_ task: Task) {
        _Concurrency.Task {
            await viewModel.deleteTask(task)
        }
    }
}

private enum TaskListFilter: String, CaseIterable, Identifiable {
    case all
    case pending
    case completed

    var id: String { rawValue }

    var title: String {
        rawValue.capitalized
    }
}

private struct TaskFilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                if isSelected {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color(red: 0.44, green: 0.24, blue: 0.82))
                        .shadow(
                            color: Color(red: 0.44, green: 0.24, blue: 0.82).opacity(0.18),
                            radius: 8,
                            x: 0,
                            y: 3
                        )
                        .foregroundStyle(.gray)
                }

                Text(title)
                    .font(.system(.subheadline, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundStyle(isSelected ? .white : .secondary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
            }
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}

private struct TaskListRowView: View {
    let task: Task

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: taskIsCompleted ? "checkmark.square.fill" : "square")
                .font(.system(size: 22, weight: .regular))
                .foregroundStyle(
                    taskIsCompleted ? Color(red: 0.44, green: 0.24, blue: 0.82) : .secondary
                )

            VStack(alignment: .leading, spacing: 6) {
                Text(task.title)
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                    .foregroundStyle(.primary)
                    .lineLimit(1)

                Text(task.dueDate)
                    .font(.system(size: 14, design: .rounded))
                    .foregroundStyle(.secondary)
                    .foregroundStyle(.primary)
                    .lineLimit(1)
            }

            Spacer(minLength: 10)

            PillView(
                pillText: task.priority,
                tint: priorityTint
            )
            .fixedSize(horizontal: true, vertical: true)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color(uiColor: .secondarySystemGroupedBackground))
                .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 4)
        )
    }

    private var taskIsCompleted: Bool {
        let normalizedStatus = task.status
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        return normalizedStatus.contains("done") || normalizedStatus.contains("completed")
    }

    private var priorityTint: Color {
        switch task.priority.lowercased() {
        case "high priority", "high":
            return Color(red: 0.92, green: 0.38, blue: 0.38)
        case "medium priority", "medium":
            return Color(red: 0.95, green: 0.64, blue: 0.24)
        case "low priority", "low":
            return Color(red: 0.28, green: 0.70, blue: 0.40)
        default:
            return Color(red: 0.44, green: 0.24, blue: 0.82)
        }
    }
}

//#Preview {
//    let repository = TasksRepositoryImpl(
//        dataSource: PreviewTaskDataSource()
//    )
//
//    NavigationStack {
//        TasksListView(
//            viewModel: TasksListViewModel(
//                getTasksUseCase: GetTasksUseCase(
//                    taskRepository: repository
//                )
//            ),
//            createTaskViewModel: CreateTaskViewModel(
//                createTaskUseCase: CreateTaskUseCase(
//                    taskRepository: repository
//                )
//            )
//        )
//    }
//}

 struct PreviewTaskDataSource: TaskDataSourceProtocol {
    
    func fetchTasks() async throws -> [TaskDTO] {
        [
            TaskDTO(id: "1", title: "UI/UX Project", description: "Design the new mobile app screens and interaction flow for TaskFlow.", dueDate: "Today, 10:00 AM", category: "Work", priority: "High Priority", status: 0),
            TaskDTO(id: "2", title: "Study Flutter", description: "Read and practice widgets.", dueDate: "Tomorrow, 09:00 AM", category: "Study", priority: "Medium Priority", status: 0),
            TaskDTO(id: "3", title: "Workout", description: "Cardio and strength.", dueDate: "Tomorrow, 06:00 PM", category: "Health", priority: "Low Priority", status: 1),
            TaskDTO(id: "4", title: "Grocery Shopping", description: "Buy groceries for the week.", dueDate: "May 22, 2024", category: "Personal", priority: "Low Priority", status: 1),
            TaskDTO(id: "5", title: "Read Book", description: "Finish the current chapter.", dueDate: "May 23, 2024", category: "Personal", priority: "Medium Priority", status: 0)
        ]
    }
    
    func createTask(_ task: TaskDTO) async throws { }

    func updateTask(_ task: TaskDTO) async throws { }

    func deleteTask(id: String) async throws { }
}
