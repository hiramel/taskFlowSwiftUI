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
    
    init(getTasksUseCase: GetTasksUseCaseProtocol) {
        self.getTasksUseCase = getTasksUseCase
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
}

enum TasksListState {
    case idle
    case loading
    case loaded([Task])
    case failed(String)
}
