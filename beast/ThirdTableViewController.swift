//
//  ThirdTableViewController.swift
//  beast
//
//  Created by havisha tiruvuri on 9/22/17.
//  Copyright © 2017 havisha tiruvuri. All rights reserved.
//

import UIKit

import CoreData

class ThirdTableViewController: UITableViewController{
    
 
var list = [Beast]()
    
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchAllItems() {
        
        
        do {
           let result = try managedObjectContext.fetch(Beast.fetchRequest())
            list = result as! [Beast]
        } catch {
            print("\(error)")
        }
        //
        //    // For FILTERING and SORTING USE THIS
        //
        let fetchRequest:NSFetchRequest<Beast> = Beast.fetchRequest()
        
        let dogPredicate = NSPredicate(format: "beasted == %@", "1")
//        let firstSort = NSSortDescriptor(key: "text", ascending:true)
       // let SecondSort = NSSortDescriptor(key: "beasted", ascending:true)
        
        fetchRequest.predicate = NSCompoundPredicate(type: .and, subpredicates: [dogPredicate])
//        fetchRequest.sortDescriptors = [firstSort]
        
        do {
            list = try managedObjectContext.fetch(fetchRequest)
        } catch {
            print(error)
        }
        
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath) as! secondTableViewCell
//        if(list[indexPath.row].beasted == true) {
            cell.Beasttitle?.text = list[indexPath.row].text
        let date = list[indexPath.row].date
        let dateFormatter = DateFormatter()
        //format 1
        dateFormatter.dateFormat = "E MM dd"
        let strDate = dateFormatter.string(from: date as! Date)
//
        cell.selectedDate?.text = strDate
//           print(cell.Beasttitle?.text!)
//      }
        return cell
    }
    
    
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        managedObjectContext.delete(list[indexPath.row])
        do{
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        list.remove(at: indexPath.row)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        self.title = "Beasted"
        super.viewDidLoad()
     //  fetchAllItem()
        fetchAllItems()
         tableView.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
