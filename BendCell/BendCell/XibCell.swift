//
//  XibCell.swift
//  BendCell
//
//  Created by Pawel Kowalczuk on 06/05/2017.
//  Copyright © 2017 Pawel Kowalczuk. All rights reserved.
//

import Foundation
import UIKit

class XibCell: BendableCell {
    @IBOutlet private weak var someImage: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
