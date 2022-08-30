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

    //MARK: - View lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier:
       cellIdentifier)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int ) -> Int
    {
            return 3
        
    }
   
    override func tableView(
      _ tableView: UITableView,
      didSelectRowAt indexPath: IndexPath
    ){
      performSegue(withIdentifier: "ShowChecklist", sender: nil)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier, for: indexPath)
          cell.textLabel!.text = "List \(indexPath.row)"
          return cell
    }

}
