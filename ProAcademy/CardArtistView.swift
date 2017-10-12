//
//  CardArtistView.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 10/10/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

class CardArtistView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var mainLine: UILabel!
    @IBOutlet weak var title: UILabel!
    
    override init(frame: CGRect) { // for using in code
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) { // for using in IB
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("ArtistView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }

}
