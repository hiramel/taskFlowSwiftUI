//
//  TasksRepositoryImpl.swift
//  TaskFlow
//
//  Created by Hiram Elguézabal Jiménez on 19/06/26.
//

import Foundation

final class TasksRepositoryImpl: TasksRepositoryProtocol {

//instancia de Datasources
//inicializacion de Datasources
    private let dataSource: RemoteTaskDataSourceProtocol
    
    init(dataSource: RemoteTaskDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    

    func getTasks() async throws -> [Task] {
        let dtos = try await dataSource.fetchUsers()
        
        //implementacion del la instancia de datasources y llamar a metodo de Tasks
        return dtos.map { $0.toDomain() }
    }
    
    
}
