//
//  MainTabView.swift
//  TaskFlow
//
//  Created by Hiram Elguézabal Jiménez on 18/06/26.
//

import SwiftUI

struct MainTabView: View {
    
    var viewModel: TasksListViewModel
    
    var body: some View {
        TabView {
            NavigationStack {
                TasksDashboardView()
            }
            .tabItem {
                Label("Dashboard", systemImage: "house")
            }
            NavigationStack {
                TasksListView(viewModel: viewModel)
            }
            .tabItem {
                Label("Tasks", systemImage: "checklist")
            }
            NavigationStack {
                TasksCategoriesView()
            }
            .tabItem {
                Label("Categories", systemImage: "tag")
            }
            NavigationStack {
                TasksFlowSettings()
            }
            .tabItem {
                Label("Settings", systemImage: "gearshape")
            }
        }
    }
}

#Preview {
    //MainTabView()
}
