//
//  ViewController.swift
//  Todos
//
//  Created by Ammar Younas on 8/26/22.
//

import UIKit


class CheckListViewController: UITableViewController,AddItemViewControllerDelegate  {
    
    // MARK: - Variables
    
   
    var checklist: Checklist!
    
    // MARK: - View LifeCycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
//        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
        title = checklist.name
//        loadChecklistItems()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue,sender: Any?)
    {
        // 1
        if segue.identifier == "AddItem"
        {
            // 2
            let controller = segue.destination as! AddItemViewController
            // 3
            controller.delegate = self
        }
        else if segue.identifier == "EditItem" {
            let controller = segue.destination as! AddItemViewController
            controller.delegate = self
            if let indexPath = tableView.indexPath(
              for: sender as! UITableViewCell) {
                controller.itemToEdit = checklist.items[indexPath.row]
            }
        }
    }
    
}
extension CheckListViewController
{
    // MARK: - Delegates & DataSource
    
    // Add Item ViewController Delegates
    func addItemViewControllerDidCancel(_ controller: AddItemViewController)
    {
        navigationController?.popViewController(animated: true)
    }
    func addItemViewController(_ controller: AddItemViewController,didFinishAdding item: ChecklistItem)
    {
        // Seeting Index for new row
        let newRowIndex = checklist.items.count
        // Appending to items array
        checklist.items.append(item)
        // Setting variable indexPath with new row index
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        // Storing paths to indexpaths
        let indexPaths = [indexPath]
        // Inserting new Row
        tableView.insertRows(at: indexPaths, with: .automatic)
//        saveChecklistItems()
        // Going back to main screen
        navigationController?.popViewController(animated:true)
    }
    // Number of rows to show
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)    -> Int
    {
        checklist.items.count
        
    }
    // Cells for Rows
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ChecklistItem",
            for: indexPath)
        let item = checklist.items[indexPath.row]
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }
    // Did Select Row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if let cell = tableView.cellForRow(at: indexPath)
        {
            let item = checklist.items[indexPath.row]
            item.checked.toggle()
            configureCheckmark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
//        saveChecklistItems()
    }
    
    // Configuring check Marks
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem
    )
    {
    let label = cell.viewWithTag(1001) as! UILabel
      if item.checked {
        label.text = "✓"
    } else {
        label.text = ""
      }
    }
    func configureText( for cell: UITableViewCell, with item: ChecklistItem)
    {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    // Swipe to delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath )
    {
        // 1
        checklist.items.remove(at: indexPath.row)
        // 2
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
//        saveChecklistItems()
    }
    func addItemViewController(
      _ controller: AddItemViewController,
      didFinishEditing item: ChecklistItem
    ){
        if let index = checklist.items.firstIndex(of: item) {
        let indexPath = IndexPath(row: index, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) {
          configureText(for: cell, with: item)
        }
    }
//    saveChecklistItems()
    navigationController?.popViewController(animated: true)
    
    }
    
    //MARK: - Data Persistence
//    func documentsDirectory() -> URL {
//      let paths = FileManager.default.urls(
//        for: .documentDirectory,
//        in: .userDomainMask)
//      return paths[0]
//    }
//    func dataFilePath() -> URL {
//      return
//    documentsDirectory().appendingPathComponent("Checklists.plist")
//    }
//    func saveChecklistItems() {
//      // 1
//      let encoder = PropertyListEncoder()
//      // 2
//      do {
//    // 3
//          let data = try encoder.encode(checklist.items)
//        // 4
//        try data.write(
//          to: dataFilePath(),
//          options: Data.WritingOptions.atomic)
//        // 5
//    }
//        catch
//        { // 6
//        print("Error encoding item array: \(error.localizedDescription)")
//        }
//
//    }
    
//    func loadChecklistItems()
//    {
//      // 1
//      let path = dataFilePath()
//      // 2
//      if let data = try? Data(contentsOf: path) {
//    // 3
//        let decoder = PropertyListDecoder()
//        do {
//    // 4
//            checklist.items = try decoder.decode(
//            [ChecklistItem].self,
//            from: data)
//        } catch {
//          print("Error decoding item array: \(error.localizedDescription)")
//    } }
//    }
}

