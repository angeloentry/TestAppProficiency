//
//  ImageCellViewModel.swift
//  TestAppProficiency
//
//  Created by user167484 on 4/21/20.
//  Copyright © 2020 Allen Savio. All rights reserved.
//

import Foundation
import UIKit

class ImageCellViewModel: RowViewModel {
    var identifier = "imageDetailCell"
    var imageCache: NSCache<NSString, UIImage>?
    var didLoadImage: ((Bool) -> Void)?
    
    var title = ""
    var description = ""
    var image: UIImage? {
        didSet {
            didLoadImage?(true)
        }
    }
    
    init(model: Model, cache: NSCache<NSString, UIImage>? = nil) {
        defer {
            self.model = model
        }
        self.imageCache = cache
    }
    
    var model: Model? {
        didSet {
            title = model?.title ?? ""
            description = model?.desc ?? ""
            getImage(from: model?.image ?? "")
        }
    }
    
    func getImage(from urlString: String) {
        if let image = imageCache?.object(forKey: NSString(string: urlString)) {
            self.image = image
        } else {
            UIImage.from(url: urlString) { [weak self] (image) in
                self?.imageCache?.setObject(image, forKey: NSString(string: self?.model?.image ?? ""))
                self?.image = image
            }
        }
    }
}
