//
//  TaskDTO.swift
//  TaskFlow
//
//  Created by Hiram Elguézabal Jiménez on 19/06/26.
//

import Foundation

struct TaskDTO: Codable {

    let id: String
    let title: String
    let description: String
    let dueDate: String
    let category: String
    let priority: String
    let status: Int
}
