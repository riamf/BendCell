//
//  MyTableViewCell.swift
//  BendCell
//
//  Created by Pawel Kowalczuk on 06/05/2017.
//  Copyright © 2017 Pawel Kowalczuk. All rights reserved.
//

import Foundation
import UIKit

class MyTableViewCell: BendableCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCell()
    }
    
    fileprivate func setupCell() {
        
        let imageView = UIImageView(image: UIImage(named: "swift_icon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        imageView.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0.0).isActive = true
    }
}
