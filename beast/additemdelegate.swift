//
//  additemdelegate.swift
//  beast
//
//  Created by havisha tiruvuri on 9/22/17.
//  Copyright © 2017 havisha tiruvuri. All rights reserved.
//

import UIKit

protocol additemdelegate: class {
    func itemSaved(by: SecondViewController, text: String, date: Date, indexPath: NSIndexPath?)
    func cancelButtonPressed(by controller: SecondViewController)
}
