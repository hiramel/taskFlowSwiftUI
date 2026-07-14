//
//  CreateTaskUseCaseProtocol.swift
//  TaskFlow
//
//  Created by Hiram Elguezabal on 08/07/26.
//

import Foundation

protocol CreateTaskUseCaseProtocol {
    func execute(task: Task) async throws
}
