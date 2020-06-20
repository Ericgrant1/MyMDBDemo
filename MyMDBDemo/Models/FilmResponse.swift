//
//  FilmResponse.swift
//  MyMDBDemo
//
//  Created by Eric Grant on 20.06.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation

struct FilmResponse: Decodable {
    
    let results: [Film]
}
