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
            
            HStack {
                Text(film.genreText)
                Text("・")
                Text(film.filmDate)
                Text(film.filmDuration)
            }
            
            Text(film.overview)
            HStack {
                if !film.filmRating.isEmpty {
                    Text(film.filmRating).foregroundColor(.yellow)
                }
                Text(film.filmScore)
            }
            
            Divider()
            
            HStack(alignment: .top, spacing: 4) {
                if film.filmCast != nil && film.filmCast!.count > 0 {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Starring").font(.headline)
                        ForEach(self.film.filmCast!.prefix(9)) { filmCast in
                            Text(filmCast.name)
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    Spacer()
                }
                
                if film.filmCrew != nil && film.filmCrew!.count > 0 {
                    VStack(alignment: .leading, spacing: 4) {
                        if film.filmDirectors != nil && film.filmDirectors!.count > 0 {
                            Text("Director(s)").font(.headline)
                            ForEach(self.film.filmDirectors!.prefix(2)) { filmCrew in
                                Text(filmCrew.name)
                            }
                        }
                        
                        if film.filmProducers != nil && film.filmProducers!.count > 0 {
                            Text("Producer(s)").font(.headline)
                                .padding(.top)
                            ForEach(self.film.filmProducers!.prefix(2)) { filmCrew in
                                Text(filmCrew.name)
                            }
                        }
                        
                        if film.filmWriters != nil && film.filmWriters!.count > 0 {
                            Text("Writer(s)").font(.headline)
                                .padding(.top)
                            ForEach(self.film.filmWriters!.prefix(2)) { filmCrew in
                                Text(filmCrew.name)
                            }
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

                }
            }
            Divider()
            
            if film.filmTrailers != nil && film.filmTrailers!.count > 0 {
                Text("Trailers").font(.headline)
                
                ForEach(film.filmTrailers!) { filmTrailer in
                    Button(action: {
                        
                    }) {
                        HStack {
                            Text(filmTrailer.name)
                            Spacer()
                            Image(systemName: "play.circle.fill")
                                .foregroundColor(Color(UIColor.systemBlue))
                        }
                    }
                }
            }
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
