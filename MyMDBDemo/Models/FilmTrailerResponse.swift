//
//  FilmTrailerResponse.swift
//  MyMDBDemo
//
//  Created by Eric Grant on 22.06.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation

struct FilmTrailerResponse: Decodable {
    
    let results: [FilmTrailer]
}
