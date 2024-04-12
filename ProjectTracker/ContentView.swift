//
//  ContentView.swift
//  ProjectTracker
//
//  Created by Wes MacDonald on 4/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var project = Project()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(project.name)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                
                Text("Start date: \(project.startDate.formatted(date: .complete, time: .omitted))")
                Text("End date: \(project.endDate.formatted(date: .complete, time: .omitted))")
                Divider()
                Text("Full Days Until End Day: \(String(project.daysTillCompletion))")
                Text("Total Project Work Days: \(String(project.workDaysUntilEnd))")
                Text("Remaining Work Days Until End Day: \(String(project.workDaysRemainingUntilEnd))")
            }
            .navigationTitle("Project Tracker")
            .toolbar {
                NavigationLink {
                    AddProjectView(project: project)
                } label: {
                    Label("Add New Project", systemImage: "square.and.pencil")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
