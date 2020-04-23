//
//  ImageLoadTableViewCell.swift
//  TestAppProficiency
//
//  Created by user167484 on 3/17/20.
//  Copyright © 2020 Allen Savio. All rights reserved.
//

import UIKit

//MARK: - Cell Protocols
protocol RowViewModel {
}

protocol CellConfiguration {
    func setup(viewModel: RowViewModel)
}

class ImageLoadTableViewCell: UITableViewCell {
    //MARK: - Properties
    lazy var titleLabel = CellLabel(sender: self)
    lazy var descLabel = CellLabel(sender: self)
    lazy var imageContent = CellImageView(sender: self)

    
    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        descLabel.font = UIFont.systemFont(ofSize: 17, weight: .light)
        descLabel.lineBreakMode = .byWordWrapping
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    //MARK: - Constraints
    func setupConstraints() {
        Constraints.shared.setConstraints(fromView: imageContent, toView: contentView,
                                          attributes: [(.leading, .leadingMargin, .equal, 0),
                                                       (.top, .topMargin, .equal, 20),
                                                       (.bottom, .bottomMargin, .lessThanOrEqual, -20)])
        Constraints.shared.setConstraints(fromView: titleLabel, toView: imageContent,
                                          attributes: [(.leading, .trailing, .equal, 20),
                                                       (.top, .top, .equal, 0)])
        Constraints.shared.setConstraints(fromView: titleLabel, toView: contentView,
                                          attributes: [(.trailing, .trailingMargin, .equal, -20)])
        Constraints.shared.setConstraints(fromView: descLabel, toView: titleLabel,
                                          attributes: [(.top, .bottom, .equal, 0),
                                                       (.leading, .leading, .equal, 0),
                                                       (.trailing, .trailing, .equal, 0)])
        Constraints.shared.setConstraints(fromView: descLabel, toView: contentView,
                                          attributes: [(.bottom, .bottomMargin, .lessThanOrEqual, -20)])
        Constraints.shared.setConstraints(fromView: imageContent,
                                          attributes: [(.height, .notAnAttribute, .equal, 50),
                                                       (.width, .notAnAttribute, .equal, 50)])
        
    }
}

extension ImageLoadTableViewCell: CellConfiguration {
    func setup(viewModel: RowViewModel) {
        guard let viewModel = viewModel as? ImageCellViewModel else { return }
        imageContent.image = viewModel.image
        titleLabel.text = viewModel.title
        descLabel.text = viewModel.description
        viewModel.didLoadImage = { isImageLoaded in
            if isImageLoaded {
                self.imageContent.image = viewModel.image
            }
        }
    }
}


