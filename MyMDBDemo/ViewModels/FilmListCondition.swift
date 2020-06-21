//
//  FilmListCondition.swift
//  MyMDBDemo
//
//  Created by Eric Grant on 22.06.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation
import SwiftUI

class FilmListCondition: ObservableObject {
    
    @Published var films: [Film]?
    @Published var downloading = false
    @Published var error: NSError?
    
    private let filmService: FilmService
    
    init(filmService: FilmService = NetworkService.shared) {
        self.filmService = filmService
    }
    
    func loadFilms(with endpoint: FilmListEndpoint) {
        self.films = nil
        self.downloading = false
        self.filmService.fetchFilms(from: endpoint) { [weak self] (result) in
            guard let self = self else { return }
            self.downloading = false
            
            switch result {
            case .success(let response):
                self.films = response.results
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
}
