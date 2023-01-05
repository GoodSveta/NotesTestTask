//
//  NotesDB+CoreDataProperties.swift
//  Notes
//
//  Created by mac on 24.12.22.
//
//

import Foundation
import CoreData


extension NotesDB {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<NotesDB> {
        return NSFetchRequest<NotesDB>(entityName: "NotesDB")
    }
    
    @nonobjc public class func fetchRequestDelete(date: String) -> NSFetchRequest<NotesDB> {
        let request = NSFetchRequest<NotesDB>(entityName: "NotesDB")
        request.predicate = NSPredicate(format: "date == %@", date)
        return request
    }
    
    @NSManaged public var header: String?
    @NSManaged public var note: String?
    @NSManaged public var date: String?
    @NSManaged public var color: Data?
    @NSManaged public var font: Data?
    
    
    func getMapped() -> Note {
        return Note(header: header,
                    note: note,
                    date: date,
                    color: color,
                    font: font)
    }
    
    func setValues(notes: [Note]) {
        self.note = notes.first?.note
        self.header = notes.first?.header
        self.date = notes.first?.date
        self.color = notes.first?.color
        self.font = notes.first?.font
    }
}
extension NotesDB : Identifiable {
    
}
