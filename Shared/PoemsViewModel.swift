//
//  PoemsViewModel.swift
//  PoemsViewModel
//
//  Created by Nathanael Roberton on 7/27/21.
//

import SwiftUI

final class PoemsViewModel: ObservableObject {
    @Published var poems:[Poem] = []
    
    func fetchAllPoems() {
        poems = PersistenceController.shared.fetchPoems()
    }
}
