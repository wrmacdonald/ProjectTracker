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
