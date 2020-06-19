//
//  FilmService.swift
//  MyMDBDemo
//
//  Created by Eric Grant on 20.06.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation

protocol FilmService {
    
    func fetchFilms(from endpoint: FilmListEndpoint, completion: @escaping (Result<FilmResponse, FilmError>) -> ())
    func fetchFilm(id: Int, completion: @escaping (Result<Film, FilmError>) -> ())
    func searchFilm(query: String, completion: @escaping (Result<FilmResponse, FilmError>) -> ())
}

enum FilmListEndpoint: String {
    case popular
    case nowPlaying = "now_playing"
    case upcoming
    case topRated = "top_rated"
    
    var specification: String {
        switch self {
        case .popular:
            return "Popular"
        case .nowPlaying:
            return "Now Playing"
        case .upcoming:
            return "Upcoming"
        case .topRated:
            return "Top Rated"
        }
    }
}

enum FilmError: Error, CustomNSError {
    
    case apiError
    case unavailableEndpoint
    case unavailableResponse
    case noData
    case serialisationError
    
    var localizedDescription: String {
        switch self {
        case .apiError:
            return "Failed to fetch data"
        case .unavailableEndpoint:
            return "Unavailable endpoint"
        case .unavailableResponse:
            return "Unavailable response"
        case .noData:
            return "No Data"
        case .serialisationError:
            return "Failed to decode request data"
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}
