//
//  NetworkService.swift
//  MyMDBDemo
//
//  Created by Eric Grant on 20.06.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation

class NetworkService: FilmService {
    
    static let shared = NetworkService()
    private init() {}
    
    private let apiKey = "3ea764cc804c1157b6a32481ab478536"
    private let baseAPIUrl = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    
    
    func fetchFilms(from endpoint: FilmListEndpoint, completion: @escaping (Result<FilmResponse, FilmError>) -> ()) {
        
    }
    
    func fetchFilm(id: Int, completion: @escaping (Result<Film, FilmError>) -> ()) {
        
    }
    
    func searchFilm(query: String, completion: @escaping (Result<FilmResponse, FilmError>) -> ()) {
        
    }
}
