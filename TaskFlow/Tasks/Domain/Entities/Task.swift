//
//  Task.swift
//  TaskFlow
//
//  Created by Hiram Elguézabal Jiménez on 18/06/26.
//

import Foundation

struct Task: Identifiable{
    let id: String
    let title: String
    let description: String
    let dueDate: String
    let category: String
    let priority: String
    let status: String
}
