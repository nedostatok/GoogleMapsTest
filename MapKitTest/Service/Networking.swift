//
//  Networking.swift
//  MapKitTest
//
//  Created by User on 21.01.2021.
//

import Foundation

class NetworService {
    static let shared = NetworService()

    func loadPlaces(completion: @escaping (ResponseEnum<Places>) -> ()) {
        
        guard let url = URL(string: "https://2fjd9l3x1l.api.quickmocker.com/kyiv/places") else { return }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                let taskError = NSError(domain: "domain", code: ErrorCode.taskError.rawValue, userInfo: nil)
                completion(.Error(taskError))
                return
            }
            
            guard let data = data else {
                let emptyData = NSError(domain: "domain", code: ErrorCode.emptyData.rawValue, userInfo: nil)
                completion(.Error(emptyData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(Places.self, from: data)
                completion(.Value(response))
                
            } catch {
                let parseError = NSError(domain: "", code: ErrorCode.parseError.rawValue, userInfo: nil)
                completion(.Error(parseError))
            }
        }.resume()
    }
}

