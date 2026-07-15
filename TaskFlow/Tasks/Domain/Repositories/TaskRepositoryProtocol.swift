//
//  TaskRepositoryProtocol.swift
//  TaskFlow
//
//  Created by Hiram Elguézabal Jiménez on 19/06/26.
//

import Foundation

protocol TasksRepositoryProtocol {
    func getTasks() async throws -> [Task]
    func createTask(_ task: Task) async throws
    func deleteTask(id: String) async throws
}
