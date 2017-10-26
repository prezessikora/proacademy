//
//  DetailCardArtistView.swift
//  ProAcademy
//
//  Created by Krzysztof Sikora on 20/10/2017.
//  Copyright © 2017 Design Love. All rights reserved.
//

import UIKit

class DetailCardArtistView: UIView  {
    
    
    @IBOutlet weak var desciptionTextView: UITextView!
    @IBOutlet var contentView: UIView!
    
    
    override init(frame: CGRect) { // for using in code
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) { // for using in IB
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("DetailArtistView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }
    
   

}
