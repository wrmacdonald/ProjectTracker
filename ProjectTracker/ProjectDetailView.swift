//
//  ProjectDetailView.swift
//  ProjectTracker
//
//  Created by Wes MacDonald on 4/21/24.
//

import SwiftData
import SwiftUI

struct ProjectDetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    let project: Project
    
    @State private var days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

    
    var body: some View {
        ScrollView() {
            Section {
                Text("Start: \(project.startDate.formatted(date: .complete, time: .omitted))")
                    .font(.title2)
                
                Text("End: \(project.endDate.formatted(date: .complete, time: .omitted))")
                    .font(.title2)
            }
            .padding(4)
            
            Spacer(minLength: 20)
            
            Section("Days you're available to work:") {
                HStack {
                    ForEach(0..<days.count, id:\.self) { i in
                        if project.availableWorkDays.contains(i) {
                            Text(days[i])
                                .frame(width: 40, height: 40)
                                .background(Color.blue.clipShape(.rect(cornerRadius: 5)))
                        }
                    }
                }
            }
            
            Spacer(minLength: 20)
            
            HStack {
                DaysTile(
                    days: project.numWorkDaysNowUntilEnd,
                    description: "Work Days Remaining"
                )
                .padding()
                
                DaysTile(
                    days: project.numWorkDaysStartUntilEnd,
                    description: "Total Project Work Days"
                )
                .padding()
            }
        }
        .navigationTitle(project.name)
        .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    do {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Project.self, configurations: configuration)
        let example = Project(
            name: "Write My First Book",
            startDate: Date.init(timeIntervalSinceNow: -86400 * 5),
            endDate: Date.init(timeIntervalSinceNow: 86400 * 5),
            availableWorkDays: [1,2,3,4,5,6]
        )
        
        return ProjectDetailView(project: example)
            .modelContainer(container)
    } catch {
        return Text("Cannot make Preview: \(error.localizedDescription)")
    }
}
