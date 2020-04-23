//
//  CellLabel.swift
//  TestAppProficiency
//
//  Created by user167484 on 4/23/20.
//  Copyright © 2020 Allen Savio. All rights reserved.
//

import UIKit

class CellLabel: UILabel {

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
        numberOfLines = 0
        self.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        sender.contentView.addSubview(self)
    }

}
