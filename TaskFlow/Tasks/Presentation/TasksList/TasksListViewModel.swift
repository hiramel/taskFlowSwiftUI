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
class TasksListViewModel {
    
    var tasks:[Task] = []    
    private let getTasksUseCase: GetTasksUseCaseProtocol
    
    init(getTasksUseCase: GetTasksUseCaseProtocol) {
        self.getTasksUseCase = getTasksUseCase
    }
    
    func loadTasks() async {
        do {
            tasks = try await getTasksUseCase.execute()
        } catch {
            print(error)
        }
    }
}
