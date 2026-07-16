//
//  UpdateTaskUseCase.swift
//  TaskFlow
//
//  Created by Hiram Elguezabal on 14/07/26.
//

import Foundation

struct UpdateTaskUseCase: UpdateTaskUseCaseProtocol {

    private let taskRepository: TasksRepositoryProtocol

    init(taskRepository: TasksRepositoryProtocol) {
        self.taskRepository = taskRepository
    }

    func execute(task: Task) async throws {
        try await taskRepository.updateTask(task)
    }
}
///// AHORITA YA LLEVO UNA PARTE DE UPDATE TASK CONCRETAMENTE TENGO QUE CREAR UN NUEVO VIEWMODEL. ESTOY TRATANDO DE IMPLEMENTARLO YO.

