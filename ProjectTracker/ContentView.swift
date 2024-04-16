//
//  ContentView.swift
//  ProjectTracker
//
//  Created by Wes MacDonald on 4/11/24.
//

import SwiftUI

struct DaysTile: View {
    let days: Int
    let description: String
    
    var body: some View {
        VStack {
            Text(String(days))
                .font(.largeTitle)
            Text(description)
                .font(.subheadline)
                .multilineTextAlignment(.center)
        }
//        .frame(width: 120, height: 120, alignment: .center)
        .frame(minWidth: 140, maxWidth: 160, minHeight: 140, maxHeight: 160)
        .background(.purple)
        .cornerRadius(10)
        .foregroundStyle(.white)
        .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var project = Project()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(project.name)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                
                Text("Start Date: \(project.startDate.formatted(date: .abbreviated, time: .omitted))")
                Text("End Date: \(project.endDate.formatted(date: .abbreviated, time: .omitted))")
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                    DaysTile(
                        days: project.workDaysUntilEnd,
                        description: "Total Project Work Days"
                    )
                    DaysTile(
                        days: project.workDaysRemainingUntilEnd,
                        description: "Full Work Days Remaining"
                    )
                }
            }
            .padding()
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
