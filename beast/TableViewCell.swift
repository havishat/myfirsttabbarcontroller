//
//  TableViewCell.swift
//  beast
//
//  Created by havisha tiruvuri on 9/22/17.
//  Copyright © 2017 havisha tiruvuri. All rights reserved.
//

import UIKit

import UIKit


class firstTableViewcell: UITableViewCell {
    weak var delegate: firstdelegate?
    @IBOutlet weak var BeastLabel: UILabel!
    
    @IBOutlet weak var beasted: UIButton!
    
    @IBAction func beastedenter(_ sender: UIButton) {
        print(BeastLabel.text!)
        delegate?.beastadd(by: self, with: BeastLabel.text!)
    }
    
}
