//
//  CoreDataManager.swift
//  Notes
//
//  Created by mac on 24.12.22.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NotesDB")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveNoteInDB(notes: [Note]) {
        let notesDB =  NotesDB(context: context)
        notesDB.setValues(notes: notes)
        self.context.insert(notesDB)
        saveContext()
    }
    
    func getFromDB() -> [Note] {
        let request = NotesDB.fetchRequest()
        let sort = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sort]
        guard let paremeters = try? context.fetch(request) else { return [] }
        return paremeters.map { $0.getMapped() }
    }
    
    func cleareDBbyDate(date: String) {
        let noteDelete = NotesDB.fetchRequestDelete(date: date)
        guard let notesDeleteDB = try? self.context.fetch(noteDelete).first else { return }
        context.delete(notesDeleteDB)
        saveContext()
        
    }
    
    func saveContext () {
        let context = context
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func deleteAllInDB() {
        let request = NotesDB.fetchRequest()
        do {
            let notesDB = try self.context.fetch(request)
            notesDB.forEach {
                self.context.delete($0)
            }
            self.saveContext()
            NotificationCenter.default.post(name: NSNotification.Name("NotesDataBaseDidChange"), object: nil)
            saveContext()
        } catch (let e) {
            print(e.localizedDescription)
        }
    }
}

