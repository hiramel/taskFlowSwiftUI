//
//  EditTaskViewModel.swift
//  TaskFlow
//
//  Created by Hiram Elguezabal on 14/07/26.
//

import Foundation
import Observation

@Observable
@MainActor

final class EditTaskViewModel {
    
    var title: String
    var description: String
    var dueDate: String
    var category: String
    var priority: String
    var state: EditTaskState = .idle
    var updatedTask: Task?
    
    private let task: Task
    private let updateTaskUseCase: UpdateTaskUseCaseProtocol
    
    init(task: Task, updateTaskUseCase: UpdateTaskUseCaseProtocol) {
        self.task = task
        self.updateTaskUseCase = updateTaskUseCase
        
        self.title = task.title
        self.description = task.description
        self.dueDate = task.dueDate
        self.category = task.category
        self.priority = task.priority
    }
    
    var isSaving: Bool {
         if case .saving = state {
             return true
         }
         return false
     }
    
    var canSave: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !isSaving
    }
    
    func saveTask() async -> Bool {
            guard canSave else { return false }

            state = .saving

            let updatedTask = Task(
                id: task.id,
                title: title,
                description: description,
                dueDate: dueDate,
                category: category,
                priority: priority,
                status: task.status
            )

            do {
                try await updateTaskUseCase.execute(task: updatedTask)
                self.updatedTask = updatedTask
                state = .saved
                return true
            } catch {
                state = .failed(error.localizedDescription)
                return false
            }
        }
}

enum EditTaskState {
    case idle
    case saving
    case saved
    case failed(String)
}
