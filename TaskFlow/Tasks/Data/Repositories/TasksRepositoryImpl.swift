//
//  TasksRepositoryImpl.swift
//  TaskFlow
//
//  Created by Hiram Elguézabal Jiménez on 19/06/26.
//

import Foundation

final class TasksRepositoryImpl: TasksRepositoryProtocol {
    
    private let dataSource: RemoteTaskDataSourceProtocol
    init(dataSource: RemoteTaskDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func getTasks() async throws -> [Task] {
        let dtos = try await dataSource.fetchTasks()
        return dtos.map { $0.toDomain() }
    }
}
