//
//  GetTasksUseCaseProtocol.swift
//  TaskFlow
//
//  Created by Hiram Elguézabal Jiménez on 19/06/26.
//

import Foundation

protocol GetTasksUseCaseProtocol {
    func execute() async throws -> [Task]
}
