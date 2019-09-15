import UIKit

class TableViewController: UITableViewController {
    
    @IBOutlet weak var button1: UIBarButtonItem!
    
    @IBAction func buttonColor1(_ sender: UIBarButtonItem) {
        if UserDefaults.standard.bool(forKey: "colorForCell") == true {
            self.tableView.backgroundColor = UIColor(red: 121/255, green: 121/255.0, blue: 121/255, alpha: 1.0)
            UserDefaults.standard.set(false, forKey: "colorForCell")
        } else {
            self.tableView.backgroundColor = UIColor.white
            UserDefaults.standard.set(true, forKey: "colorForCell")
        }
        self.tableView.reloadData()
    }
    
    @IBAction func pushEditAction(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func pushAddAction(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add new item", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "New item"
        }
        let alertAction1 = UIAlertAction(title: "Cancel", style: .default) { (alert) in
            
        }
        let alertAction2 = UIAlertAction(title: "Create", style: .cancel) { (alert) in
            let newItem = alertController.textFields![0].text
            addItem(nameItem: newItem!)
            self.tableView.reloadData()
        }
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        present(alertController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToDoList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let currentItem = ToDoList[indexPath.row]
        cell.textLabel?.text = currentItem["Name"] as? String
        
        if (currentItem["isCompleted"] as? Bool) == true {
            cell.imageView?.image = #imageLiteral(resourceName: "check")
            if tableView.backgroundColor == UIColor(red: 121/255, green: 121/255.0, blue: 121/255, alpha: 1.0) {
                cell.backgroundColor = UIColor(red: 140/255, green: 140/255.0, blue: 140/255, alpha: 1.0)
                cell.textLabel?.textColor = UIColor.white //UIColor(red: 255/255, green: 10/255.0, blue: 10/255, alpha: 1.0)
                cell.imageView?.image = #imageLiteral(resourceName: "check_black")
            } else if tableView.backgroundColor == UIColor.white {
                cell.backgroundColor = UIColor(red: 200/255, green: 200/255.0, blue: 200/255, alpha: 1.0)
                cell.textLabel?.textColor = UIColor.black
            }
        } else {
            cell.imageView?.image = #imageLiteral(resourceName: "uncheck")
            if tableView.backgroundColor == UIColor(red: 121/255, green: 121/255.0, blue: 121/255, alpha: 1.0) {
                cell.backgroundColor = UIColor(red: 155/255, green: 155/255.0, blue: 155/255, alpha: 1.0)
                cell.textLabel?.textColor = UIColor.white //UIColor(red: 255/255, green: 10/255.0, blue: 10/255, alpha: 1.0)
            } else if tableView.backgroundColor == UIColor.white {
                cell.backgroundColor = UIColor(red: 250/255, green: 250/255.0, blue: 250/255, alpha: 1.0)
                cell.textLabel?.textColor = UIColor.black
            }
        }
        
        if tableView.isEditing {
            cell.textLabel?.alpha = 0.4
            cell.imageView?.alpha = 0.4
        } else {
            cell.textLabel?.alpha = 1.0
            cell.imageView?.alpha = 1.0
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if changeState(at: indexPath.row) {
            tableView.cellForRow(at: indexPath)?.imageView?.image = #imageLiteral(resourceName: "check")
        } else {
            tableView.cellForRow(at: indexPath)?.imageView?.image = #imageLiteral(resourceName: "uncheck")
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        moveItem(fromIndex: fromIndexPath.row, toIndex: to.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if tableView.isEditing {
            return .none
        } else {
            return .delete
        }
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
