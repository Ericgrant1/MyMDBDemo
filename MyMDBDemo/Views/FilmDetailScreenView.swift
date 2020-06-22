//
//  FilmDetailScreenView.swift
//  MyMDBDemo
//
//  Created by Eric Grant on 22.06.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import SwiftUI

struct FilmDetailScreenView: View {
    
    let filmID: Int
    @ObservedObject private var filmDetailCondition = FilmDetailCondition()
    
    var body: some View {
        ZStack {
            ScreenLoadingView(download: self.filmDetailCondition.downloading, error: self.filmDetailCondition.error) {
                self.filmDetailCondition.loadFilm(id: self.filmID)
            }
            
            if filmDetailCondition.film != nil {
                FilmDetailList(film: self.filmDetailCondition.film!)
            }
        }
        .navigationBarTitle(filmDetailCondition.film?.title ?? "")
        .onAppear {
            self.filmDetailCondition.loadFilm(id: self.filmID)
        }
    }
}

struct FilmDetailList: View {
    
    let film: Film
    
    var body: some View {
        List {
            FilmDetailPoster(posterURL: self.film.backgroundURL)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
    }
}

struct FilmDetailPoster: View {
    
    let posterURL: URL
    @ObservedObject private var posterLoader = PosterLoader()
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color.gray.opacity(0.2))
            if self.posterLoader.poster != nil {
                Image(uiImage: self.posterLoader.poster!)
                .resizable()
            }
        }
        .aspectRatio(16/9, contentMode: .fill)
        .onAppear {
            self.posterLoader.loadPoster(with: self.posterURL)
        }
    }
}

struct FilmDetailScreenView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FilmDetailScreenView(filmID: Film.getFilm.id)
        }
    }
}
