//
//  NumberTableViewCell.swift
//  MVVMDemo
//
//  Created by Daniel Dorozhkin on 26/12/2021.
//

import UIKit

class NumberTableViewCell: UITableViewCell {

    @IBOutlet private weak var cellLbl: UILabel!
    
    func configure(_ item: String) {
        self.cellLbl.text = item
    }
}
