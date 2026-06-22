//
//  GetTasksUseCase.swift
//  TaskFlow
//
//  Created by Hiram Elguézabal Jiménez on 19/06/26.
//

import Foundation

struct GetTasksUseCase: GetTasksUseCaseProtocol {
    
    private let taskRepository: TasksRepositoryProtocol
    init(taskRepository: TasksRepositoryProtocol) {
        self.taskRepository = taskRepository
    }
    
    func execute() async throws -> [Task] {
        try await taskRepository.getTasks()
    }
}
