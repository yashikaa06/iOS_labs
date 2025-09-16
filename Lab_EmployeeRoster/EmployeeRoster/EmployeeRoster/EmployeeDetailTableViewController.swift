
import UIKit

protocol EmployeeDetailTableViewControllerDelegate: AnyObject {
    func employeeDetailTableViewController(_ controller: EmployeeDetailTableViewController, didUpdate employee: Employee)
}

class EmployeeDetailTableViewController: UITableViewController, UITextFieldDelegate , EmployeeTypeTableViewControllerDelegate {
    func EmployeeTypeTableViewController(_ controller: EmployeeTypeTableViewController, didSelect employeeType: EmployeeType) {
        self.employeeType = employeeType
        employeeTypeLabel.text = employeeType.description
        employeeTypeLabel.textColor = .black
    }
    
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var dobLabel: UILabel!
    @IBOutlet var employeeTypeLabel: UILabel!
    @IBOutlet var saveBarButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var dobDatePicker: UIDatePicker!
    
    
    weak var delegate: EmployeeDetailTableViewControllerDelegate?
    var employee: Employee?
    var employeeType: EmployeeType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
        updateSaveButtonState()
    }
    
    func updateView() {
        if let employee = employee {
            navigationItem.title = employee.name
            nameTextField.text = employee.name
            
            dobLabel.text = employee.dateOfBirth.formatted(date: .abbreviated, time: .omitted)
            dobLabel.textColor = .label
            employeeTypeLabel.text = employee.employeeType.description
            employeeTypeLabel.textColor = .label
        } else {
            navigationItem.title = "New Employee"
        }
    }
    
    var isEditingBirthday:Bool = false{
        didSet{
            dobDatePicker.isHidden = !isEditingBirthday
        }
    }
    
    private func updateSaveButtonState() {
        let shouldEnableSaveButton = nameTextField.text?.isEmpty == false
        saveBarButtonItem.isEnabled = shouldEnableSaveButton
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text else {
            return
        }
        
        let employee = Employee(name: name, dateOfBirth: dobDatePicker.date, employeeType: employeeType!)
        delegate?.employeeDetailTableViewController(self, didUpdate: employee)
    }
    
    
    let bdayIndexPath = IndexPath(row: 1, section: 0)
    let bdayDatePickerIndexpath = IndexPath(row: 2, section: 0)
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath==bdayIndexPath && isEditingBirthday==false{
            isEditingBirthday.toggle()
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    @IBAction func datePickerValueChanged(_ sender: Any) {
        dobLabel.text = dobDatePicker.date.formatted(date: .abbreviated, time: .omitted)
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath{
        case bdayDatePickerIndexpath where isEditingBirthday==false:
            return 0
        default :
            return UITableView.automaticDimension
        }
        
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath{
        case bdayDatePickerIndexpath :
                return 190
        default :
            return UITableView.automaticDimension
        }
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        employee = nil
    }

    @IBAction func nameTextFieldDidChange(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    func employeeTypeTableViewController(_ controller: EmployeeTypeTableViewController, didSelect employeeType: EmployeeType) {
           // Update the employeeTypeLabel with the selected type
           self.employee?.employeeType = employeeType
           employeeTypeLabel.text = employeeType.description
       }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let employeeTypeTableViewController = segue.destination as? EmployeeTypeTableViewController else { return }
        employeeTypeTableViewController.employeeType = employee?.employeeType
        employeeTypeTableViewController.delegate = self
    }
}
