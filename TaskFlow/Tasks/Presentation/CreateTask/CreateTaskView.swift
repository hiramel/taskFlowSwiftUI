//
//  CreateTaskView.swift
//  TaskFlow
//
//  Created by Hiram Elguezabal on 13/07/26.
//

import SwiftUI

struct CreateTaskView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Bindable var viewModel: CreateTaskViewModel

    let onSaved: () async -> Void
    
    var body: some View {
        NavigationStack{
            Form {
                Section("Task"){
                    TextField("Title", text: $viewModel.title)
                    TextField("Description", text: $viewModel.description, axis: .vertical)
                    TextField("Due Date", text: $viewModel.dueDate)
                }
                
                Section("Details"){
                    Picker("Category", selection: $viewModel.category) {
                        Text("Work").tag("Work")
                        Text("Study").tag("Study")
                        Text("Health").tag("Health")
                        Text("Personal").tag("Personal")
                    }

                    Picker("Priority", selection: $viewModel.priority) {
                        Text("High Priority").tag("High Priority")
                        Text("Medium Priority").tag("Medium Priority")
                        Text("Low Priority").tag("Low Priority")
                    }
                }
                
                if case .failed(let message) = viewModel.state {
                    Section {
                        Text(message)
                            .foregroundStyle(.red)
                    }
                }
                
            }
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel"){
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        save()
                    } label: {
                        if viewModel.isSaving {
                                   ProgressView()
                               } else {
                                   Text("Save")
                               }
                    }
                    .disabled(!viewModel.canSave)
                    
                }
            }
            
        }
    }
    
    private func save() {
        _Concurrency.Task {
            let didSave = await viewModel.saveTask()
            if didSave {
                await onSaved()
                dismiss()
            }
        }
    }
}

#Preview {
    CreateTaskView(
        viewModel: CreateTaskViewModel(
            createTaskUseCase: CreateTaskUseCase(
                taskRepository: TasksRepositoryImpl(
                    dataSource: PreviewTaskDataSource()
                )
            )
        ), onSaved: {}
    )
}
