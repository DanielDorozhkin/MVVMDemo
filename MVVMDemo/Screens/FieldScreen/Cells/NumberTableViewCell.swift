//
//  NumberTableViewCell.swift
//  MVVMDemo
//
//  Created by Daniel Dorozhkin on 26/12/2021.
//

import UIKit
import Reusable

final class NumberTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var cellLbl: UILabel!
    
    func configure(_ item: String) {
        self.cellLbl.text = item
    }
}
