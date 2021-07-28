//
//  ContentView.swift
//  Shared
//
//  Created by Nathanael Roberton on 7/26/21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        NavigationView {
            PoemsView()
        }
        .navigationTitle("")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
