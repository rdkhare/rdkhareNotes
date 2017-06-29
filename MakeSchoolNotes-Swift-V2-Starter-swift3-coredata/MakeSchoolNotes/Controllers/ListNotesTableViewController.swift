//
//  ListNotesTableViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit

class ListNotesTableViewController: UITableViewController {
    var notes = [Note]() {
        didSet {
            tableView.reloadData()
        }
    }
    @IBAction func unwindToListNotesViewController(_ segue: UIStoryboardSegue) {
        
        self.notes = CoreDataHelper.retrieveNotes()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "displayNote" {
                print("Table view cell tapped")
                
                // 1
                let indexPath = tableView.indexPathForSelectedRow!
                // 2
                let note = notes[indexPath.row]
                // 3
                let displayNoteViewController = segue.destination as! DisplayNoteViewController
                // 4
                displayNoteViewController.note = note
                
            } else if identifier == "addNote" {
                print("+ button tapped")
            }
        }
    }
    // 1
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // 2
        if editingStyle == .delete {
            CoreDataHelper.delete(note: notes[indexPath.row])
            notes = CoreDataHelper.retrieveNotes()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        notes = CoreDataHelper.retrieveNotes()
    }
    // 1
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    // 2
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listNotesTableViewCell", for: indexPath) as! ListNotesTableViewCell
        // 1
        let row = indexPath.row
        
        // 2
        let note = notes[row]
        
        // 3
        cell.noteTitleLabel.text = note.title
        
        // 4

        cell.noteModificationLabel.text = note.modificationTime?.convertToString()
        
        return cell
    }
}
