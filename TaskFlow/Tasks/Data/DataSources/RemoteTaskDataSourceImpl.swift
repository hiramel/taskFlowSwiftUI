//
//  RemoteTaskDataSourceImpl.swift
//  TaskFlow
//
//  Created by Hiram Elguézabal Jiménez on 19/06/26.
//

import Foundation

final class RemoteTaskDataSourceImpl: RemoteTaskDataSourceProtocol {
    
    
    private let baseURL: URL
    private let session: URLSession
    
    init(baseURL: URL, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }
    
    private let baseUrl = "https://6a3436058248ee962fa53dda.mockapi.io/api/hej/Tasks"
    
    func fetchTasks() async throws -> [TaskDTO] {
        
        let (data, response) = try await session.data(from: baseURL)

//        guard let url = URL(string: baseUrl) else {
//            throw URLError(.badURL)
//        }
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode([TaskDTO].self, from: data)
        
//        let tasks = [
//            TaskDTO(id: "1", title: "unoRemoteData", description: "soy el uno", dueDate: "Fecha1", category: "Category", priority: "Priority", status: "status"),
//            TaskDTO(id: "2", title: "dos", description: "soy el dos", dueDate: "Fecha1", category: "Category", priority: "Priority", status: "status"),
//            TaskDTO(id: "3", title: "tres", description: "soy el tres", dueDate: "Fecha1", category: "Category", priority: "Priority", status: "status"),
//            TaskDTO(id: "4", title: "cuatro", description: "soy el cuatro", dueDate: "Fecha1", category: "Category", priority: "Priority", status: "status"),
//        ]
//        return tasks
    }
}
