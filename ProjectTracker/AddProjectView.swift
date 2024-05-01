//
//  AddProjectView.swift
//  ProjectTracker
//
//  Created by Wes MacDonald on 4/11/24.
//

import SwiftUI

struct AddProjectView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = "Example Project"
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var availableWorkDays = [1, 2, 3, 4, 5]
    
    @State private var days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

    
    var body: some View {
        NavigationStack {
            Form {
                Section("Project Information") {
                    TextField("Project Name", text: $name)
                    DatePicker(
                        "Start Date",
                        selection: $startDate,
                        displayedComponents: [.date]
                    )
                    DatePicker(
                        "Completion Date",
                        selection: $endDate,
                        displayedComponents: [.date]
                    )
                }
                
                Section("What days are you available to work?") {
                    HStack {
                        ForEach(0..<days.count, id:\.self) { i in
                            Text(days[i])
                                .foregroundStyle(.black)
                                .frame(width: 40, height: 30)
                                .background(
                                    availableWorkDays.contains(i) ? Color.blue.clipShape(.rect(cornerRadius: 5)) : Color.gray.clipShape(.rect(cornerRadius: 5)))
                                .onTapGesture {
                                    if availableWorkDays.contains(i) {
                                        availableWorkDays.removeAll(where: {$0 == i})
                                    } else {
                                        availableWorkDays.append(i)
                                    }
                                }
                        }
                    }
                }
                
                Button("Save") {
                    let newProject = Project(
                        name: name,
                        startDate: startDate,
                        endDate: endDate,
                        availableWorkDays: availableWorkDays
                    )
                    modelContext.insert(newProject)
                    dismiss()
                }
            }
            .navigationTitle("Add Project")
        }
    }
}

#Preview {
    AddProjectView()
}
