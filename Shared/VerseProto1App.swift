//
//  VerseProto1App.swift
//  Shared
//
//  Created by Nathanael Roberton on 7/26/21.
//

import SwiftUI

@main
struct VerseProto1App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
