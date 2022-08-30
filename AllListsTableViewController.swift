//
//  AllListsTableViewController.swift
//  Todos
//
//  Created by Ammar Younas on 8/30/22.
//

import UIKit

class AllListsTableViewController: UITableViewController {
    
    // MARK: - Variables
    let cellIdentifier = "ChecklistCell"
    var lists = [Checklist]()
    
   
    
    //MARK: - View lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier:
       cellIdentifier)
        // 1
        var list = Checklist(name: "Birthdays")
          lists.append(list)
          list = Checklist(name: "Groceries")
          lists.append(list)
          list = Checklist(name: "Cool Apps")
          lists.append(list)
          list = Checklist(name: "To Do")
          lists.append(list)
    }
    
    // MARK: - Navigation
    override func prepare(
      for segue: UIStoryboardSegue,
      sender: Any?
    ){
    if segue.identifier == "ShowChecklist" {
        let controller = segue.destination as! CheckListViewController
        controller.checklist = sender as? Checklist
      }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int ) -> Int
    {
        return lists.count
        
    }
   
    override func tableView(
      _ tableView: UITableView,
      didSelectRowAt indexPath: IndexPath
    ){
        let checklist = lists[indexPath.row]
        performSegue( withIdentifier: "ShowChecklist", sender: checklist)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier, for: indexPath)
        let checklist = lists[indexPath.row]
          cell.textLabel!.text = checklist.name
          cell.accessoryType = .detailDisclosureButton
          return cell
    }

}
