//
//  TaskFlowApp.swift
//  TaskFlow
//
//  Created by Hiram Elguézabal Jiménez on 18/06/26.
//

import SwiftUI
import CoreData
import Observation
import FirebaseCore

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct TaskFlowApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let persistenceController = PersistenceController.shared
    let container = AppContainer()

    var body: some Scene {
        WindowGroup {
            MainTabView(viewModel: container.tasksListViewModel, createTaskViewModel: container.createTaskViewModel,
                        makeEditTaskViewModel: container.makeEditTaskViewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

final class AppContainer {
    
    private lazy var restTaskDataSource = RemoteTaskDataSourceImpl(
        baseURL: AppEnvironment.tasksBaseURL
    )
    
    private lazy var firestoreTaskDataSource = FirestoreTaskDataSourceImpl()
    
    private lazy var taskDataSource: TaskDataSourceProtocol = {
        switch AppEnvironment.taskDataSourceKind {
        case .rest:
            return self.restTaskDataSource
            
        case .firestore:
            return self.firestoreTaskDataSource
        }
    }()
    
    lazy var taskRepository = TasksRepositoryImpl(dataSource: taskDataSource)
    lazy var getTasksUseCase = GetTasksUseCase(taskRepository: taskRepository)
    lazy var deleteTasksUseCase = DeleteTaskUseCase(taskRepository: taskRepository)
    lazy var tasksListViewModel = TasksListViewModel(getTasksUseCase: getTasksUseCase, deleteTaskUseCase: deleteTasksUseCase)
    lazy var createTaskUseCase = CreateTaskUseCase(taskRepository: taskRepository)
    lazy var createTaskViewModel = CreateTaskViewModel(createTaskUseCase: createTaskUseCase)
    lazy var updateTaskUseCase = UpdateTaskUseCase(taskRepository: taskRepository)
    
    func makeEditTaskViewModel(task: Task) -> EditTaskViewModel {
        EditTaskViewModel(
            task: task,
            updateTaskUseCase: updateTaskUseCase
        )
    }
}

enum AppEnvironment {
    static let taskDataSourceKind: TaskDataSourceKind = .firestore
    static let tasksBaseURL = URL(string: "https://6a3436058248ee962fa53dda.mockapi.io/api/hej/Tasks")!
}
