//
//  EditProjectView.swift
//  ProjectTracker
//
//  Created by Wes MacDonald on 4/30/24.
//

import SwiftData
import SwiftUI

struct EditProjectView: View {
    @Bindable var project: Project
    
    let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

    
    var body: some View {
        Form {
            TextField("Name", text: $project.name)
            
            DatePicker(
                "Start Date",
                selection: $project.startDate,
                displayedComponents: [.date]
            )
            
            DatePicker(
                "Completion Date",
                selection: $project.endDate,
                displayedComponents: [.date]
            )
            
            Section("What days are you available to work?") {
                HStack {
                    ForEach(0..<days.count, id:\.self) { i in
                        Text(days[i])
                            .foregroundStyle(.black)
                            .frame(width: 40, height: 30)
                            .background(
                                project.availableWorkDays.contains(i) ? Color.blue.clipShape(.rect(cornerRadius: 5)) : Color.gray.clipShape(.rect(cornerRadius: 5)))
                            .onTapGesture {
                                if project.availableWorkDays.contains(i) {
                                    project.availableWorkDays.removeAll(where: {$0 == i})
                                } else {
                                    project.availableWorkDays.append(i)
                                }
                            }
                    }
                }
            }
        }
        .navigationTitle("Edit Project")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Project.self, configurations: config)

        let exampleProject = Project(name: "Test", startDate: .now, endDate: .now.addingTimeInterval(86400 * 5), availableWorkDays: [1,2,3,4,5])
        
        return EditProjectView(project: exampleProject)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
