//
//  CellImageView.swift
//  TestAppProficiency
//
//  Created by user167484 on 4/23/20.
//  Copyright © 2020 Allen Savio. All rights reserved.
//

import UIKit

class CellImageView: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    convenience init(sender: UITableViewCell) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
        sender.contentView.addSubview(self)
    }

}
