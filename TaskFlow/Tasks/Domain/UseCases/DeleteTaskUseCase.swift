//
//  DeleteTaskUseCase.swift
//  TaskFlow
//
//  Created by Hiram Elguezabal on 14/07/26.
//

import Foundation

struct DeleteTaskUseCase: DeleteTaskUseCaseProtocol {
    
    private let taskRepository: TasksRepositoryProtocol
    
    init(taskRepository: TasksRepositoryProtocol) {
        self.taskRepository = taskRepository
    }
    
    func execute(id: String) async throws {
        try await taskRepository.deleteTask(id: id)
    }
}
