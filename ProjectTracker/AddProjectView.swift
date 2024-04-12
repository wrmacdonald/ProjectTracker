//
//  AddProjectView.swift
//  ProjectTracker
//
//  Created by Wes MacDonald on 4/11/24.
//

import SwiftUI

struct AddProjectView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var project: Project
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Project Name", text: $project.name)
                    DatePicker(
                        "Start Date",
                        selection: $project.startDate,
                        displayedComponents: [.date]
                    )
                    DatePicker(
                        "Completion Date",
                        selection: $project.completionDate,
                        displayedComponents: [.date]
                    )
                }
                
                Section("What days are you available to work?") {
                    HStack {
                        ForEach(0..<project.days.count, id:\.self) { i in
                            Text(project.days[i])
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
                
                Button("Done") {
                    dismiss()
                }
            }
            .navigationTitle("Add Project")
        }
    }
}

#Preview {
    AddProjectView(project: Project())
}
