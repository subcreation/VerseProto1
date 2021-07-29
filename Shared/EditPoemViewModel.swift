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
    @Published var poem: Poem?
    
    init(poemToEdit poem: Poem?) {
        self.poem = poem
    }
    
    func setUpEditingView() {
        if poem != nil {
            title = poem!.title ?? ""
            body = poem!.body ?? ""
        }
    }
    
    func savePoem() {
        if poem != nil {
            editExistingPoem()
        } else {
            createNewPoem()
        }
        PersistenceController.shared.save()
    }
    
    func createNewPoem() {
        let newPoem = Poem(context: PersistenceController.shared.viewContext)
        newPoem.createdDate = Date()
        newPoem.title = title
        newPoem.body = body
    }
    
    func editExistingPoem() {
        poem!.title = title
        poem!.body = body
    }
    
    func poemIsStarted() -> Bool {
        return !title.isEmpty || !body.isEmpty
    }
}
