//
//  TaskFlowTests.swift
//  TaskFlowTests
//
//  Created by Hiram Elguézabal Jiménez on 18/06/26.
//

import XCTest
@testable import TaskFlow

final class TaskFlowTests: XCTestCase {

    func testTaskDTOToDomain() {
        //Arrange
        let dto = TaskDTO(id: "task-1", title: "Aprender CI", description: "Crear pruebas unitarias", dueDate: "2026-07-20", category: "Estudio", priority: "Alta", status: 1)
        //Act
        let task = dto.toDomain()
        
        //Assert
        XCTAssertEqual(task.id, "task-1")
        XCTAssertEqual(task.title, "Aprender CI")
        XCTAssertEqual(task.description, "Crear pruebas unitarias")
        XCTAssertEqual(task.dueDate, "2026-07-20")
        XCTAssertEqual(task.category, "Estudio")
        XCTAssertEqual(task.priority, "Alta")
        XCTAssertEqual(task.status, "1")
    }
    
    func testTaskDomainToDTO() {
        
        let task = Task(id: "task-1", title: "Leche", description: "Ir por Leche", dueDate: "2026-07-20", category: "Estudio", priority: "Media", status: "0")
        
        let taskDTO = task.toDTO()
        
        XCTAssertEqual(taskDTO.id, "task-1")
        XCTAssertEqual(taskDTO.title, "Leche")
        XCTAssertEqual(taskDTO.description, "Ir por Leche")
        XCTAssertEqual(taskDTO.dueDate, "2026-07-20")
        XCTAssertEqual(taskDTO.category, "Estudio")
        XCTAssertEqual(taskDTO.priority, "Media")
        XCTAssertEqual(taskDTO.status, 0)
        
    }

}
