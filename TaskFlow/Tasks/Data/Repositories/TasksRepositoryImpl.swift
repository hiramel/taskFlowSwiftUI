//
//  TasksRepositoryImpl.swift
//  TaskFlow
//
//  Created by Hiram Elguézabal Jiménez on 19/06/26.
//

import Foundation

final class TasksRepositoryImpl: TasksRepositoryProtocol {
    
    private let dataSource: TaskDataSourceProtocol
    
    init(dataSource: TaskDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func getTasks() async throws -> [Task] {
        let dtos = try await dataSource.fetchTasks()
        return dtos.map { $0.toDomain() }
    }
    
    func createTask(_ task: Task) async throws {
        let dto = task.toDTO()
        try await dataSource.createTask(dto)
    }
    
    func deleteTask(id: String) async throws {
        try await dataSource.deleteTask(id: id)
        
    }
}
