//
//  EditTaskView.swift
//  TaskFlow
//
//  Created by Hiram Elguezabal on 14/07/26.
//

import SwiftUI

struct EditTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var viewModel: EditTaskViewModel

    let onSaved: (Task) async -> Void

    var body: some View {
        NavigationStack {
            Form {
                Section("Task") {
                    TextField("Title", text: $viewModel.title)
                    TextField("Description", text: $viewModel.description, axis: .vertical)
                        .lineLimit(3...5)
                    TextField("Due date", text: $viewModel.dueDate)
                }

                Section("Details") {
                    Picker("Category", selection: $viewModel.category) {
                        Text("Work").tag("Work")
                        Text("Study").tag("Study")
                        Text("Health").tag("Health")
                        Text("Personal").tag("Personal")
                    }

                    Picker("Priority", selection: $viewModel.priority) {
                        Text("High").tag("High")
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
            .navigationTitle("Edit Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
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

            if didSave, let updatedTask = viewModel.updatedTask {
                await onSaved(updatedTask)
                dismiss()
            }
        }
    }
}
