//
//  EmojiTableViewController.swift
//  TableViews
//
//  Created by Yashika Geed on 18/08/25.
//

import UIKit

class EmojiTableViewController: UITableViewController {

    var emojis: [Emoji] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load saved emojis or use sample
        if let savedEmojis = Emoji.loadFromFile() {
            emojis = savedEmojis
        } else {
            emojis = Emoji.sampleEmojis()
        }
        
        // Edit button
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    @IBSegueAction func addEditEmoji(_ coder: NSCoder, sender: Any?) -> AddEditTableViewController? {
        guard let indexPath = sender as? IndexPath else {
            return AddEditTableViewController(coder: coder, emoji: nil)
        }
        return AddEditTableViewController(coder: coder, emoji: emojis[indexPath.row])
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojis.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EmojiTableViewCell
        cell.updateUI(emoji: emojis[indexPath.row])
        cell.showsReorderControl = true
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "editSegue", sender: indexPath)
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            emojis.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            Emoji.saveToFile(emojis: emojis)
        }
    }

    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let removedEmoji = emojis.remove(at: fromIndexPath.row)
        emojis.insert(removedEmoji, at: to.row)
        Emoji.saveToFile(emojis: emojis)
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    @IBAction func unwindToEmojiTVC(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveSegue",
              let addEditTVC = segue.source as? AddEditTableViewController,
              let emoji = addEditTVC.emoji else { return }
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            // Editing existing
            emojis[selectedIndexPath.row] = emoji
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
        } else {
            // Adding new
            emojis.append(emoji)
            let indexPath = IndexPath(row: emojis.count - 1, section: 0)
            tableView.insertRows(at: [indexPath], with: .fade)
        }
        Emoji.saveToFile(emojis: emojis)
    }
}

