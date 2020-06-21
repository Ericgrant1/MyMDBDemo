//
//  FilmDetailCondition.swift
//  MyMDBDemo
//
//  Created by Eric Grant on 22.06.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation
import SwiftUI

class FilmDetailCondition: ObservableObject {
    
    private let filmService: FilmService
    
    @Published var film: Film?
    @Published var downloading = false
    @Published var error: NSError?
    
    init(filmService: FilmService = NetworkService.shared) {
        self.filmService = filmService
    }
    
    func loadFilm(id: Int) {
        self.film = nil
        self.downloading = false
        self.filmService.fetchFilm(id: id) { [weak self] (result) in
            guard let self = self else { return }
            
            self.downloading = false
            switch result {
            case .success(let film):
                self.film = film
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
}
