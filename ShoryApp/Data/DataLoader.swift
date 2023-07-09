//
//  DataLoader.swift
//  ShoryApp
//
//  Created by Dhaval Soni on 09/07/2023.
//

import Foundation

class DataLoader {
    func loadData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                let error = NSError(domain: "HTTPError", code: statusCode, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            if let data = data {
                completion(.success(data))
            } else {
                let error = NSError(domain: "DataError", code: -1, userInfo: nil)
                completion(.failure(error))
            }
        }.resume()
    }
}
