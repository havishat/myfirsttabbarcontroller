//
//  SecondViewController.swift
//  beast
//
//  Created by havisha tiruvuri on 9/22/17.
//  Copyright © 2017 havisha tiruvuri. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var itemTextField: UITextField!
    weak var delegate: additemdelegate?
    
    var item: String?
    var indexPath: NSIndexPath?
    var itemDate = Date()
    
    //    @IBOutlet weak var itemTextField: UITextField!
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let text = itemTextField.text!
        delegate?.itemSaved(by: self, text: text, date: itemDate, indexPath: indexPath)
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.cancelButtonPressed(by: self)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        itemTextField.text = item

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
