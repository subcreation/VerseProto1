//
//  EditPoemViewModel.swift
//  EditPoemViewModel
//
//  Created by Nathanael Roberton on 7/27/21.
//

import SwiftUI

final class EditPoemViewModel: ObservableObject {
    @Published var title = ""
    @Published var body = ""
    
    func createNewPoem() {
        let newPoem = Poem(context: PersistenceController.shared.viewContext)
        newPoem.createdDate = Date()
        newPoem.title = title
        newPoem.body = body
        
        PersistenceController.shared.save()
    }
}
