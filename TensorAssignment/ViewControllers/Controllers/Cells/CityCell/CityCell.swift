//
//  CityCell.swift
//  TensorAssignment
//
//  Created by EAD on 10/10/23.
//

import UIKit

class CityCell: UITableViewCell {
    
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var btnSelect: UIControl!
    @IBOutlet weak var imgSelect: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
