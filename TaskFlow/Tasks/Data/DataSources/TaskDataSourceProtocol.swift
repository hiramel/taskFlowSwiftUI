//
//  RemoteTaskDataSourceProtocol.swift
//  TaskFlow
//
//  Created by Hiram Elguézabal Jiménez on 19/06/26.
//
import Foundation

protocol TaskDataSourceProtocol {
    func fetchTasks() async throws -> [TaskDTO]
    func createTask(_ task: TaskDTO) async throws
    func updateTask(_ task: TaskDTO) async throws
    func deleteTask(id: String) async throws
}
