//
//  FilmSearchCondition.swift
//  MyMDBDemo
//
//  Created by Eric Grant on 23.06.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class FilmSearchCondition: ObservableObject {
    
    @Published var request = ""
    @Published var films: [Film]?
    @Published var downloading = false
    @Published var error: NSError?
    
    private var subscriptionMark: AnyCancellable?
    
    let filmService: FilmService
    init(filmService: FilmService = NetworkService.shared) {
        self.filmService = filmService
    }
    
    func startObserve() {
        guard subscriptionMark == nil else { return }
        
        self.subscriptionMark = self.$request
            .map { [weak self] info in
                self?.films = nil
                self?.error = nil
                return info
                
        }.throttle(for: 1, scheduler: DispatchQueue.main, latest: true)
            .sink { [weak self] in self?.searchCondition(request: $0) }
    }
    
    func searchCondition(request: String) {
        self.films = nil
        self.downloading = false
        self.error = nil
        
        guard !request.isEmpty else {
            return
        }
        
        self.downloading = true
        self.filmService.searchFilm(request: request) { [weak self] (result) in
            guard let self = self, self.request == request else { return }
            
            self.downloading = false
            switch result {
            case .success(let response):
                self.films = response.results
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
    deinit {
        self.subscriptionMark?.cancel()
        self.subscriptionMark = nil
    }
}
