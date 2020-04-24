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
    //MARK: - Properties
    var identifier = "imageDetailCell"
    var imageCache: NSCache<NSString, UIImage>?
    var didLoadImage: ((Bool) -> Void)?
    
    var title = ""
    var description = ""
    var imageURL: String? {
        didSet {
            getImage(from: imageURL ?? "")
        }
    }
    var image: UIImage? {
        didSet {
            didLoadImage?(true)
        }
    }
    
    //MARK: - Initialisers
    init(model: Model, cache: NSCache<NSString, UIImage>? = nil) {
        defer {
            imageURL = model.image ?? ""
        }
        title = model.title ?? ""
        description = model.desc ?? ""
        self.imageCache = cache
    }
    
    func getImage(from urlString: String) {
        if let image = imageCache?.object(forKey: NSString(string: urlString)) {
            self.image = image
        } else {
            UIImage.from(url: urlString) { [weak self] (image) in
                self?.imageCache?.setObject(image, forKey: NSString(string: urlString))
                self?.image = image
            }
        }
    }
}
