//
//  UpdateTaskUseCaseProtocol.swift
//  TaskFlow
//
//  Created by Hiram Elguezabal on 14/07/26.
//

import Foundation

protocol UpdateTaskUseCaseProtocol {
    func execute(task: Task) async throws
}
