//
//  Persistence.swift
//  Shared
//
//  Created by Nathanael Roberton on 7/26/21.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newPoem = Poem(context: viewContext)
            newPoem.title = "Preview Poem"
            newPoem.body = """
the preview poem had a body
had a poem preview body
had a poem preview
had a body
preview
a body
poem
"""
            newPoem.createdDate = Date()
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentCloudKitContainer
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "VerseProto1")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving to CoreData: ", error.localizedDescription)
        }
    }
    
    func fetchPoems() -> [Poem] {
        let request: NSFetchRequest<Poem> = Poem.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Poem.createdDate, ascending: true)]
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    
}
