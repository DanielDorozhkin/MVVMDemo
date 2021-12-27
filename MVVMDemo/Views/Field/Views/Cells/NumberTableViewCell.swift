//
//  NumberTableViewCell.swift
//  MVVMDemo
//
//  Created by Daniel Dorozhkin on 26/12/2021.
//

import UIKit

class NumberTableViewCell: UITableViewCell {

    @IBOutlet weak var cellLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ item: String) {
        self.cellLbl.text = item
    }
}
