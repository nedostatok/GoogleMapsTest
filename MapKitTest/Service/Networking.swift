//
//  Networking.swift
//  MapKitTest
//
//  Created by User on 21.01.2021.
//

import Foundation

class NetworService {
    static let shared = NetworService()
    typealias Handle = (Result<Places,Error>) -> ()

    func loadPlaces(completion: @escaping Handle) -> () {
        
        guard let url = URL(string: "https://2fjd9l3x1l.api.quickmocker.com/kyiv/places") else { return }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                let taskError = NSError(domain: "domain", code: ErrorCode.taskError.rawValue, userInfo: nil)
                completion(.failure(taskError))
                return
            }
            
            guard let data = data else {
                let emptyData = NSError(domain: "domain", code: ErrorCode.emptyData.rawValue, userInfo: nil)
                completion(.failure(emptyData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(Places.self, from: data)
                completion(.success(response))
                
            } catch {
                let parseError = NSError(domain: "", code: ErrorCode.parseError.rawValue, userInfo: nil)
                completion(.failure(parseError))
            }
        }.resume()
    }
}

