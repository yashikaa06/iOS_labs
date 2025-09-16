//
//  EmployeeTypeTableViewController.swift
//  EmployeeRoster
//
//  Created by Yashika Geed on 15/09/25.
//

import UIKit

protocol EmployeeTypeTableViewControllerDelegate:AnyObject{
    
    func EmployeeTypeTableViewController(_ controller:EmployeeTypeTableViewController, didSelect employeeType:EmployeeType)
    
}



class EmployeeTypeTableViewController: UITableViewController {

   
    var employeeType : EmployeeType?
    weak var delegate : EmployeeTypeTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

   
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return EmployeeType.allCases.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeType", for: indexPath)

        let type = EmployeeType.allCases[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = type.description
        cell.contentConfiguration = content
        
        if type == self.employeeType{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedEmployeeType = EmployeeType.allCases[indexPath.row]
        self.employeeType = selectedEmployeeType
        delegate?.EmployeeTypeTableViewController(self,didSelect: selectedEmployeeType)
        tableView.reloadData()
    }
    
  
    

    

    

}
