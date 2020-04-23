//
//  Request.swift/Users/user167484/Desktop/TestAppProficiencySwift/TestAppProficiency/data.json
//  TestAppProficiency
//
//  Created by user167484 on 3/19/20.
//  Copyright © 2020 Allen Savio. All rights reserved.
//

import Foundation

//MARK: - Networking Utility
enum Request {
    case fetchData
    case fetchImage(url: String)
    
    typealias RequestCompletion<T> = (_ response: URLResponse?, _ data: T) -> Void
    typealias FailureCompletion = (_ error: Error) -> Void
    
    var url: URL? {
        switch self {
        case .fetchData:
            return URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
        case .fetchImage(let urlString):
            return URL(string: urlString)
        }
    }
    
    enum ImageError: Error {
        case wrongURL
    }
    
    func execute<T: Decodable>(success: @escaping RequestCompletion<T>, failure: @escaping FailureCompletion) {
        guard let url = url else { failure(ImageError.wrongURL); return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    failure(error)
                }
            } else {
                guard let data = data else { return }
                guard let string = String(data: data, encoding: String.Encoding.isoLatin1) else { return }
                guard let properData = string.data(using: .utf8, allowLossyConversion: true) else { return }
       
                switch self {
                case .fetchData:
                    do {
                        let decoder = JSONDecoder()
                        let newData = try decoder.decode(T.self, from: properData)
                        DispatchQueue.main.async {
                            success(response, newData)
                        }
                    } catch let error {
                        print("Caught Error - > \(error)")
                        DispatchQueue.main.async {
                            failure(error)
                        }
                        
                    }
                case .fetchImage:
                    DispatchQueue.main.async {
                        success(response, data as! T)
                    }
                }
            }
        }.resume()
    }
}

