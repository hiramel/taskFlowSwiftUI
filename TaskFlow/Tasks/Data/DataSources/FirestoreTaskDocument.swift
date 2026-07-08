//
//  FirestoreTaskDocument.swift
//  TaskFlow
//
//  Created by Hiram Elguezabal on 08/07/26.
//

import Foundation
import FirebaseFirestore

struct FirestoreTaskDocument: Codable {
    @DocumentID var id: String?

    let title: String
    let description: String
    let dueDate: String
    let category: String
    let priority: String
    let status: Int
}

extension FirestoreTaskDocument {
    func toDTO() -> TaskDTO {
        TaskDTO(
            id: id ?? UUID().uuidString,
            title: title,
            description: description,
            dueDate: dueDate,
            category: category,
            priority: priority,
            status: status
        )
    }
}

extension TaskDTO {
    func toFirestoreDocument() -> FirestoreTaskDocument {
        FirestoreTaskDocument(
            id: id,
            title: title,
            description: description,
            dueDate: dueDate,
            category: category,
            priority: priority,
            status: status
        )
    }
}
