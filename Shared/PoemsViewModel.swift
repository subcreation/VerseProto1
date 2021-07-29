//
//  PoemsViewModel.swift
//  PoemsViewModel
//
//  Created by Nathanael Roberton on 7/27/21.
//

import SwiftUI

final class PoemsViewModel: ObservableObject {
    @Published var poems: [Poem] = []
    @Published var isNavigationLinkActive = false
    @Published var selectedPoem: Poem?
    
    func fetchAllPoems() {
        poems = PersistenceController.shared.fetchPoems()
    }
    
    func delete(at index: IndexSet) {
        guard let indexRow = index.first else { return }
        let poemToDelete = poems[indexRow]
        PersistenceController.shared.viewContext.delete(poemToDelete)
        PersistenceController.shared.save()
        
        fetchAllPoems()
    }
}
