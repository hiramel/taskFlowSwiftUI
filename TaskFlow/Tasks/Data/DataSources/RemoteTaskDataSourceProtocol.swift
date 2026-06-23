//
//  RemoteTaskDataSourceProtocol.swift
//  TaskFlow
//
//  Created by Hiram Elguézabal Jiménez on 19/06/26.
//

import Foundation
protocol RemoteTaskDataSourceProtocol {
    func fetchTasks() async throws -> [TaskDTO]
}
