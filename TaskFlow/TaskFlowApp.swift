//
//  TaskFlowApp.swift
//  TaskFlow
//
//  Created by Hiram Elguézabal Jiménez on 18/06/26.
//

import SwiftUI
import CoreData
import Observation

@main
struct TaskFlowApp: App {
    let persistenceController = PersistenceController.shared
    let container = AppContainer()


    var body: some Scene {
        WindowGroup {
            MainTabView(viewModel: container.tasksListViewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

final class AppContainer {
    
    private let baseURL = URL(string: "https://6a3436058248ee962fa53dda.mockapi.io/api/hej/Tasks")!

    
    lazy var remoteTaskDataSource = RemoteTaskDataSourceImpl(baseURL: AppEnvironment.tasksBaseURL)
    lazy var taskRepository = TasksRepositoryImpl(dataSource: remoteTaskDataSource)
    lazy var getTasksUseCase = GetTasksUseCase(taskRepository: taskRepository)
    lazy var tasksListViewModel = TasksListViewModel(getTasksUseCase: getTasksUseCase)
}

enum AppEnvironment {
    static let tasksBaseURL = URL(string: "https://6a3436058248ee962fa53dda.mockapi.io/api/hej/Tasks")!
}
