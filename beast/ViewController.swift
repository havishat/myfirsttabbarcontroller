//
//  ViewController.swift
//  beast
//
//  Created by havisha tiruvuri on 9/22/17.
//  Copyright © 2017 havisha tiruvuri. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, additemdelegate, firstdelegate{

//    
  
    
    //Core Data
    var items = [Beast]()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //TableView
    @IBOutlet weak var TableView: UITableView!
    
    //additembutton
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "additem", sender: sender)
        
        
    }
    
   
    @IBAction func Beastview(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    //feach data
    
    func fetchAllItems() {
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Beast")
//        do {
//            let result = try managedObjectContext.fetch(request)
//            items = result as! [Beast]
//        } catch {
//            print("\(error)")
//        }
        
        let fetchRequest:NSFetchRequest<Beast> = Beast.fetchRequest()
        
        let dogPredicate = NSPredicate(format: "beasted == %@", "0")
       // let firstSort = NSSortDescriptor(key: "text", ascending:true)
        // let SecondSort = NSSortDescriptor(key: "beasted", ascending:true)
        
        fetchRequest.predicate = NSCompoundPredicate(type: .and, subpredicates: [dogPredicate])
       // fetchRequest.sortDescriptors = [firstSort]
        
        do {
            items = try managedObjectContext.fetch(fetchRequest)
        } catch {
            print(error)
        }

    }
    
    
    //delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        managedObjectContext.delete(item)
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        items.remove(at: indexPath.row)
        TableView.reloadData()
    }

    //tableview for number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return an integer that indicates how many rows (cells) to draw
        return items.count
    }
    
    //tableview for cell row data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get the UITableViewCell and create number it with data then return it
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as! firstTableViewcell
        
        // return cell so that Table View knows what to render in each row
//        cell.beasted.tag = indexPath.row
//        print(cell.beasted.tag)
        
        
//        if(items[indexPath.row].beasted == false) {
            cell.BeastLabel?.text = items[indexPath.row].text
//        }
        cell.delegate = self
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected")
        performSegue(withIdentifier: "additem", sender: indexPath)
        TableView.dataSource = self
    }
    
    //prepare segure for action from first view to second view
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if type(of: sender!) == NSIndexPath.self {
            print(sender!)
            print("2")
            let navigationController = segue.destination as! UINavigationController
            let addItemTableViewController = navigationController.topViewController as! SecondViewController
            addItemTableViewController.delegate = self
            
            let indexPath = sender as! NSIndexPath
            
            let item = items[indexPath.row].text
            addItemTableViewController.item = item
            addItemTableViewController.indexPath = indexPath
            
        } else if type(of: sender!) == UIBarButtonItem.self  {
            
            print("1")
            
            let navigationController = segue.destination as! UINavigationController
            let addItemTableViewController = navigationController.topViewController as! SecondViewController
            addItemTableViewController.delegate = self
        }
    }
    
    
    //CancelButton from Second view
    func cancelButtonPressed(by controller: SecondViewController){
        print("I'm the hidden controller, But I am responding to the cancel button press on the top view controller.")
        dismiss(animated: true, completion: nil)
    }
    //SaveButton from Second view
    func itemSaved(by controller: SecondViewController, text: String, date: Date, indexPath: NSIndexPath?){
        print("Recived Text from top view: \(text)")
        if let ip = indexPath {
            let item = items[ip.row]
            item.text = text
            items[ip.row].date = date as NSDate
        } else {
            let item = NSEntityDescription.insertNewObject(forEntityName: "Beast", into: managedObjectContext) as! Beast
            item.date = date as NSDate
            item.text = text
            item.beasted = false
            items.append(item)
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
    
        TableView.reloadData()
        dismiss(animated: true, completion: nil)
        
    }
    
    func beastadd(by controller: firstTableViewcell, with text: String) {
        
        if let index = TableView.indexPath(for: controller) {
            print("this is text", text)
            let y = items[(index.row)]
            print("printing item boolean",y.beasted)

            y.beasted = true
            print(beastadd)
            items.remove(at: index.row)
            
            do {
                try managedObjectContext.save()
            } catch {
                print("\(error)")
            }
        }
        
    }
    
        
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        self.title = "To Beasted"
        fetchAllItems()
        TableView.reloadData()
        TableView.dataSource = self
        TableView.delegate = self
        
        for i in items {
            print(i.beasted)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

