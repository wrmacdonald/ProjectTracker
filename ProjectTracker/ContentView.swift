//
//  ContentView.swift
//  ProjectTracker
//
//  Created by Wes MacDonald on 4/11/24.
//

import SwiftData
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
        .frame(width: 100, height: 100, alignment: .center)
        .background(.purple)
        .cornerRadius(10)
        .foregroundStyle(.white)
        .shadow(radius: 5)
    }
}

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Project.endDate) var projects: [Project]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(projects) { project in
                    NavigationLink(value: project) {
                        HStack {
                            DaysTile(
                                days: project.numWorkDaysNowUntilEnd,
                                description: "Work Days Remaining"
                            )
                            .padding(.trailing, 5)
                            
                            VStack(alignment: .leading) {
                                Text(project.name)
                                    .font(.title)
                                
                                Text("Start: \(project.startDate.formatted(date: .abbreviated, time: .omitted))")
                                    .foregroundStyle(.secondary)
                                
                                Text("End: \(project.endDate.formatted(date: .abbreviated, time: .omitted))")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteProjects)
            }
            .navigationTitle("Project Tracker")
            .toolbar {
                NavigationLink {
                    AddProjectView()
                } label: {
                    Label("Add New Project", systemImage: "plus")
                }
            }
        }
    }
    
    func deleteProjects(at offsets: IndexSet) {
        for offset in offsets {
            let project = projects[offset]
            modelContext.delete(project)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Project.self, configurations: config)
        
        let calendar = Calendar.current
        var components = DateComponents()
        
        components.day = 4
        let fourDaysOut = calendar.date(byAdding: components, to: .now)
        let example = Project(
            name: "Draw a whole book!",
            startDate: .now,
            endDate: fourDaysOut!,
            availableWorkDays: [1,2,3]
        )
        container.mainContext.insert(example)
        
        components.year = 2024
        components.month = 3
        components.day = 20
        if let date = calendar.date(from: components) {
            let example2 = Project(
                name: "Test Project 2",
                startDate: date,
                endDate: .now,
                availableWorkDays: [1,2,3]
            )
            container.mainContext.insert(example2)
        }
        
        components.year = 2024
        components.month = 4
        components.day = 18
        if let date = calendar.date(from: components) {
            components.year = 2024
            components.month = 4
            components.day = 24
            if let date2 = calendar.date(from: components) {
                let example2 = Project(
                    name: "Octopus Book",
                    startDate: date,
                    endDate: date2,
                    availableWorkDays: [1,2,3,4,5]
                )
                container.mainContext.insert(example2)
            }
        }
            
        
        return ContentView()
            .modelContainer(container)
    } catch {
        return Text("Failed to created preview: \(error.localizedDescription)")
    }
}
