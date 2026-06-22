//
//  TaskFlowApp.swift
//  TaskFlow
//
//  Created by Hiram Elguézabal Jiménez on 18/06/26.
//

import SwiftUI
import CoreData

@main
struct TaskFlowApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            let tasksRemoteData = RemoteTaskDataSourceImpl()
            let taskRepository = TasksRepositoryImpl(dataSource: tasksRemoteData)
            let getTasksUseCase = GetTasksUseCase(taskRepository: taskRepository)
            
            let viewModel = TasksListViewModel(getTasksUseCase: getTasksUseCase)
            MainTabView(viewModel: viewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
