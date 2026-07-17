//
//  DeleteTasksUseCaseProtocol.swift
//  TaskFlow
//
//  Created by Hiram Elguezabal on 14/07/26.
//

import Foundation

protocol DeleteTaskUseCaseProtocol {
    func execute(id: String) async throws
}
