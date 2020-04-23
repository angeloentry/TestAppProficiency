//
//  Image+Utilities.swift
//  TestAppProficiency
//
//  Created by user167484 on 4/23/20.
//  Copyright © 2020 Allen Savio. All rights reserved.
//

import UIKit

//MARK: - Imageview Utilities
extension UIImage {
    typealias ImageCompletion = (_ image: UIImage) -> Void
    static func from(url: String?, completion: @escaping ImageCompletion) {
        guard let placeholderImage = UIImage(named: "placeholder") else { return }
        guard let url = url else { return }
        Request.fetchImage(url: url).execute(success: { (response, data: Data) in
            let image = UIImage(data: data)
            completion(image ?? placeholderImage)
        }, failure: { (error) in
            print(error)
            completion(placeholderImage)
        })
    }
}
