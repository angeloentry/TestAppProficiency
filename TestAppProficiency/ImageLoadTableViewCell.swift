//
//  ImageLoadTableViewCell.swift
//  TestAppProficiency
//
//  Created by user167484 on 3/17/20.
//  Copyright © 2020 Allen Savio. All rights reserved.
//

import UIKit

class ImageLoadTableViewCell: UITableViewCell {
    var titleLabel = UILabel()
    var descLabel = UILabel()
    var imageContent = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        imageContent.contentMode = .scaleAspectFit
        imageContent.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        descLabel.numberOfLines = 0
        descLabel.lineBreakMode = .byWordWrapping
        
        contentView.addSubview(imageContent)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descLabel)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setup() {
        let a = NSLayoutConstraint(item: imageContent, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leadingMargin, multiplier: 1, constant: 0)
        let b = NSLayoutConstraint(item: imageContent, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .topMargin, multiplier: 1, constant: 20)
        
        let d = NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: imageContent, attribute: .trailing, multiplier: 1, constant: 20)
        let f = NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: imageContent, attribute: .top, multiplier: 1, constant: 0)
        let g = NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailingMargin, multiplier: 1, constant: -20)

        let e = NSLayoutConstraint(item: descLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 0)
        let h = NSLayoutConstraint(item: descLabel, attribute: .leading, relatedBy: .equal, toItem: titleLabel, attribute: .leading, multiplier: 1, constant: 0)
        let i = NSLayoutConstraint(item: descLabel, attribute: .trailing, relatedBy: .equal, toItem: titleLabel, attribute: .trailing, multiplier: 1, constant: 0)
        let j = NSLayoutConstraint(item: descLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottomMargin, multiplier: 1, constant: -20)
        
        let k = NSLayoutConstraint(item: imageContent, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50)
        let l = NSLayoutConstraint(item: imageContent, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50)
        NSLayoutConstraint.activate([a,b,d,e,f,g,h,i,j,k,l])
//        NSLayoutConstraint.activate([a,b,c,d])

    }

}
