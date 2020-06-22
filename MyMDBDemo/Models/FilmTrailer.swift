//
//  FilmTrailer.swift
//  MyMDBDemo
//
//  Created by Eric Grant on 22.06.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation

struct FilmTrailer: Decodable, Identifiable {
    
    let id: String
    let key: String
    let name: String
    let site: String
    
    var siteURL: URL? {
        guard site == "YouTube" else {
            return nil
        }
        return URL(string: "https://youtube.com/watch?v=\(key)")
    }
}
