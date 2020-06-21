//
//  FilmExtension.swift
//  MyMDBDemo
//
//  Created by Eric Grant on 21.06.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation

extension Film {
    static var getFilms: [Film] {
        let filmResponse: FilmResponse? = try? Bundle.main.loadJSONDecod(jsonFile: "filmlist")
        return filmResponse!.results
    }
    
    static var getFilm: Film {
        getFilms[0]
    }
}
