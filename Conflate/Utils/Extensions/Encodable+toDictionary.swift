//
//  Encodable+toDictionary.swift
//  Conflate
//
//  Created by Paweł on 02/01/2019.
//  Copyright © 2019 CO.KrystynaKruchcovska. All rights reserved.
//

import Foundation

extension Encodable {
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
    }
}
