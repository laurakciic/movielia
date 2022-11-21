//
//  UserDefaults.swift
//  movielia
//
//  Created by Laura on 31.10.2022..
//

import Foundation

extension UserDefaults {
    
    func load<T: Codable>() -> T? where T: Decodable {                                 // dataType: T.Type
        guard let data = data(forKey: "\(T.self)") else { return nil }                 // self.object(forKey: "\(T.self)") as? Data
        return try? JSONDecoder().decode(T.self, from: data)
    }

    func save<T: Codable>(_ data: T?) {
        guard let encoded = try? JSONEncoder().encode(data) else { return }
        set(encoded, forKey: "\(T.self)")
    }
}
