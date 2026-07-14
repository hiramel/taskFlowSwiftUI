//
//  CreateTaskViewModel.swift
//  TaskFlow
//
//  Created by Hiram Elguezabal on 13/07/26.
//

import Foundation
import Observation

@Observable
@MainActor

final class CreateTaskViewModel {
    
    var title = ""
    var description = ""
    var dueDate = ""
    var category = "Work"
    var priority = "Medium Priority"
    var state: CreateTaskState = .idle
    
    
    private let createTaskUseCase: CreateTaskUseCaseProtocol
    
    init(createTaskUseCase: CreateTaskUseCaseProtocol) {
        self.createTaskUseCase = createTaskUseCase
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

        let task = Task(
            id: UUID().uuidString,
            title: title,
            description: description,
            dueDate: dueDate,
            category: category,
            priority: priority,
            status: "0"
        )

        do {
            try await createTaskUseCase.execute(task: task)
            resetFields()
            state = .saved
            return true
        } catch {
            state = .failed(error.localizedDescription)
            return false
        }
    }
    
    private func resetFields() {
        title = ""
        description = ""
        dueDate = ""
        category = "Work"
        priority = "Medium Priority"
    }
}

enum CreateTaskState {
    case idle
    case saving
    case saved
    case failed(String)
}
