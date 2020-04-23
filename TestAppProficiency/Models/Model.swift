//
//  Model.swift
//  TestAppProficiency
//
//  Created by user167484 on 4/21/20.
//  Copyright © 2020 Allen Savio. All rights reserved.
//

import Foundation

struct Model: Codable {
    var title: String? = ""
    var desc: String? = ""
    var image: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case desc = "description"
        case image = "imageHref"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        desc = try values.decodeIfPresent(String.self, forKey: .desc)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }
}

