//
//  ViewController.swift
//  Todos
//
//  Created by Ammar Younas on 8/26/22.
//

import UIKit


class CheckListViewController: UITableViewController,AddItemViewControllerDelegate  {
    
    // MARK: - Variables
    var row0item = ChecklistItem()
    var items = [ChecklistItem]()
    
    // MARK: - View LifeCycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
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
    func addItemViewController(_ controller: AddItemViewController,didFinishEditing item: ChecklistItem)
    {
        // Seeting Index for new row
        let newRowIndex = items.count
        // Appending to items array
        items.append(item)
        // Setting variable indexPath with new row index
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        // Storing paths to indexpaths
        let indexPaths = [indexPath]
        // Inserting new Row
        tableView.insertRows(at: indexPaths, with: .automatic)
        // Going back to main screen
        navigationController?.popViewController(animated:true)
    }
    // Number of rows to show
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)    -> Int
    {
        return items.count
        
    }
    // Cells for Rows
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ChecklistItem",
            for: indexPath)
        let item = items[indexPath.row]
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }
    // Did Select Row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if let cell = tableView.cellForRow(at: indexPath)
        {
            let item = items[indexPath.row]
            item.checked.toggle()
            configureCheckmark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
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
        items.remove(at: indexPath.row)
        // 2
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
}

