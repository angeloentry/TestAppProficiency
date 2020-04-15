//
//  Request.swift
//  TestAppProficiency
//
//  Created by user167484 on 3/19/20.
//  Copyright © 2020 Allen Savio. All rights reserved.
//

import Foundation

enum Request {
    case fetchData
    
    typealias RequestCompletion<T> = (_ response: URLResponse?, _ data: T) -> Void
    func execute<T: Decodable>(completion: @escaping RequestCompletion<T>) {
        switch self {
        case .fetchData:
//            let url = URL(string: "http://localhost:8080")!
            let url = Bundle.main.url(forResource: "data", withExtension: "json")
            
            let session = URLSession(configuration: .default)
            var request = URLRequest(url: url!)
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            session.dataTask(with: request) { (data, response, error) in
                print("Error is -> ", error)
                if let json = data {
                    do {                        let decoder = JSONDecoder()
                        let newData = try decoder.decode(T.self, from: json)
                        DispatchQueue.main.async {
                            completion(response, newData)
                        }
                        
                    } catch let error {
                        print("Caught Error - > \(error)")
                    }
                }
            }.resume()
        }
        
        
    }
}
