//
//  ProjectTrackerApp.swift
//  ProjectTracker
//
//  Created by Wes MacDonald on 4/11/24.
//

import SwiftData
import SwiftUI

@main
struct ProjectTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Project.self)
    }
}
