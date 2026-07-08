//
//  FirestoreTaskDataSourceImpl.swift
//  TaskFlow
//
//  Created by Hiram Elguezabal on 08/07/26.
//


import Foundation
import FirebaseFirestore

final class FirestoreTaskDataSourceImpl: TaskDataSourceProtocol {

    private let db: Firestore
    private let collectionName = "tasks"

    init(db: Firestore = Firestore.firestore()) {
        self.db = db
    }

    func fetchTasks() async throws -> [TaskDTO] {
        let snapshot = try await db
            .collection(collectionName)
            .getDocuments()

        return try snapshot.documents.map { documentSnapshot in
            let firestoreDocument = try documentSnapshot.data(as: FirestoreTaskDocument.self)
            return firestoreDocument.toDTO()
        }
    }

    func createTask(_ task: TaskDTO) async throws {
        let firestoreDocument = task.toFirestoreDocument()

        try db
            .collection(collectionName)
            .document(task.id)
            .setData(from: firestoreDocument)
    }

    func updateTask(_ task: TaskDTO) async throws {
        let firestoreDocument = task.toFirestoreDocument()

        try db
            .collection(collectionName)
            .document(task.id)
            .setData(from: firestoreDocument, merge: true)
    }

    func deleteTask(id: String) async throws {
        try await db
            .collection(collectionName)
            .document(id)
            .delete()
    }
}
