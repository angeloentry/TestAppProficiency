//
//  ConstraintManager.swift
//  TestAppProficiency
//
//  Created by user167484 on 4/21/20.
//  Copyright © 2020 Allen Savio. All rights reserved.
//

import Foundation
import UIKit

class Constraints {
    
    typealias  ConstraintForView = (view: UIView, attribute: NSLayoutConstraint.Attribute)
    static func setConstraint(from: ConstraintForView, to: ConstraintForView, constant: CGFloat, related: NSLayoutConstraint.Relation) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: from.view, attribute: from.attribute, relatedBy: .equal, toItem: to.view, attribute: to.attribute, multiplier: 1, constant: constant)
    }
    
    static func setConstraints(fromView: UIView, toView: UIView? = nil, attributes: [(from: NSLayoutConstraint.Attribute, to: NSLayoutConstraint.Attribute, relation: NSLayoutConstraint.Relation, constant: CGFloat)]) {
        var constraints: [NSLayoutConstraint] = []
        for attribute in attributes {
            let a =  NSLayoutConstraint(item: fromView, attribute: attribute.from, relatedBy: attribute.relation, toItem: toView, attribute: attribute.to, multiplier: 1, constant: attribute.constant)
            constraints.append(a)
        }
        NSLayoutConstraint.activate(constraints)
    }
    
    
}
