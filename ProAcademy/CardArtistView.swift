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
    
    @IBOutlet weak var quote: UILabel!
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
        
        contentView.translatesAutoresizingMaskIntoConstraints = false

        contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        
        contentView.frame = self.bounds
    }

}
