//
//  TasksListViewModel.swift
//  TaskFlow
//
//  Created by Hiram Elguézabal Jiménez on 18/06/26.
//

import Foundation
import Observation

@Observable
@MainActor
final class TasksListViewModel {
    
//    var tasks:[Task] = []
//    var isLoading = false
    
    var state: TasksListState = .idle
    
    private let getTasksUseCase: GetTasksUseCaseProtocol
    private let deleteTaskUseCase: DeleteTaskUseCaseProtocol
    
    init(getTasksUseCase: GetTasksUseCaseProtocol, deleteTaskUseCase: DeleteTaskUseCaseProtocol) {
        self.getTasksUseCase = getTasksUseCase
        self.deleteTaskUseCase = deleteTaskUseCase
    }
    
    func loadTasks() async {
        state = .loading

        do {
            let tasks = try await getTasksUseCase.execute()
            state = .loaded(tasks)//TODO aqui es donde pasa el task a la vista, investigar esto despues.
        } catch {
            state = .failed(error.localizedDescription)
        }
    }
    
    func deleteTask(_ task : Task) async {
        do {
            try await deleteTaskUseCase.execute(id: task.id)
            await loadTasks()
        } catch {
            state = .failed(error.localizedDescription)
        }
    }
}

enum TasksListState {
    case idle
    case loading
    case loaded([Task])
    case failed(String)
}
