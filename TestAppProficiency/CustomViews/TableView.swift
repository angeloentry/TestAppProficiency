//
//  TableView.swift
//  TestAppProficiency
//
//  Created by user167484 on 4/22/20.
//  Copyright © 2020 Allen Savio. All rights reserved.
//

import UIKit

class TableView: UITableView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    convenience init(sender: UIViewController) {
        self.init()
        delegate = sender as? UITableViewDelegate
        dataSource = sender as? UITableViewDataSource
        translatesAutoresizingMaskIntoConstraints = false
        estimatedRowHeight = 100
        rowHeight = UITableView.automaticDimension
        refreshControl = UIRefreshControl()
        setConstraints(to: sender.view)
    }
    
    func setConstraints(to view: UIView) {
        view.addSubview(self)
        Constraints.setConstraints(fromView: self, toView: view,
                                          attributes: [(.leading, .leadingMargin, .equal, 0),
                                                       (.trailing, .trailingMargin, .equal, 0),
                                                       (.top, .topMargin, .equal, 0),
                                                       (.bottom, .bottomMargin, .equal, 0)]
        )
    }
    
    
    
}
