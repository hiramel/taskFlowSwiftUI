//
//  RemoteTaskDataSourceImpl.swift
//  TaskFlow
//
//  Created by Hiram Elguézabal Jiménez on 19/06/26.
//

import Foundation

final class RemoteTaskDataSourceImpl: TaskDataSourceProtocol {
    private let baseURL: URL
    private let session: URLSession
    
    init(baseURL: URL, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }
        
    func fetchTasks() async throws -> [TaskDTO] {
        
        let (data, response) = try await session.data(from: baseURL)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode([TaskDTO].self, from: data)
        
    }
    
    func createTask(_ task: TaskDTO) async throws {
        throw URLError(.unsupportedURL)
    }
    
    func updateTask(_ task: TaskDTO) async throws {
        throw URLError(.unsupportedURL)
    }
    
    func deleteTask(id: String) async throws {
        throw URLError(.unsupportedURL)
    }
    
    
    

}
