//
//  CreateTaskUseCase.swift
//  TaskFlow
//
//  Created by Hiram Elguezabal on 08/07/26.
//

import Foundation

struct CreateTaskUseCase: CreateTaskUseCaseProtocol {

    private let taskRepository: TasksRepositoryProtocol

    init(taskRepository: TasksRepositoryProtocol) {
        self.taskRepository = taskRepository
    }

    func execute(task: Task) async throws {
        try await taskRepository.createTask(task)
    }
}
