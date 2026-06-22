//
//  TaskMapper.swift
//  TaskFlow
//
//  Created by Hiram Elguézabal Jiménez on 19/06/26.
//

import Foundation

extension TaskDTO {
    func toDomain() -> Task {
        Task(id: id,
             title: title,
             description: description,
             dueDate: dueDate,
             category: category,
             priority: priority,
             status: String(status)
        )
    }
}
