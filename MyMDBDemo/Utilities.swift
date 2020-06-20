//
//  Utilities.swift
//  MyMDBDemo
//
//  Created by Eric Grant on 20.06.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation

class Utilities {
    
    static let jsonDecoder: JSONDecoder = {
        let jd = JSONDecoder()
        jd.keyDecodingStrategy = .convertFromSnakeCase
        jd.dateDecodingStrategy = .formatted(dateFormatter)
        return jd
    }()
    
    static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-mm-dd"
        return df
    }()
}
