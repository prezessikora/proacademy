//
//  FAQAnwserCellTableViewCell.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 19/10/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

class FAQAnwserCellTableViewCell: UITableViewCell {

    @IBOutlet weak var anwserText: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
