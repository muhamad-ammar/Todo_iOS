//
//  AddItemViewControllerTableViewController.swift
//  Todos
//
//  Created by Ammar Younas on 8/26/22.
//

import UIKit

// MARK: - Protocols
protocol AddItemViewControllerDelegate: AnyObject
{
    func addItemViewControllerDidCancel(
        _ controller: AddItemViewController)
    func addItemViewController(_ controller: AddItemViewController, didFinishEditing item: ChecklistItem)
}
// MARK: - Class
class AddItemViewController: UITableViewController, UITextFieldDelegate{
    
    // MARK: - Outlets
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    // MARK: - Delegates
    weak var delegate: AddItemViewControllerDelegate?
    
    //MARK: onload fucntion
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        if let item = itemToEdit
        {
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.isEnabled = true
        }
    }
    
    // MARK: - Views
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String ) -> Bool
    {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        return true
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    
    var itemToEdit: ChecklistItem?
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath ) -> IndexPath?
    {
        return nil
    }
    
    // MARK: IB Actions
    @IBAction func cancel()
    {
        delegate?.addItemViewControllerDidCancel(self)
    }
    
    @IBAction func done()
    {
        if let item = itemToEdit
        {
            item.text = textField.text!
            delegate?.addItemViewController(
                self,
                didFinishEditing: item)
        }
        else
        {
            let item = ChecklistItem()
            item.text = textField.text!
            delegate?.addItemViewController(self, didFinishEditing: item)
        }
    }
}
