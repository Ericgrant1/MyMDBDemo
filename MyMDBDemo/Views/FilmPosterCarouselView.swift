//
//  FilmPosterCarouselView.swift
//  MyMDBDemo
//
//  Created by Eric Grant on 22.06.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import SwiftUI

struct FilmPosterCarouselView: View {
    
    let filmTitle: String
    let films: [Film]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(filmTitle)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 14) {
                    ForEach(self.films) { film in
                        FilmPosterView(film: film)
                        .padding(.leading, film.id == self.films.first!.id ? 14 : 0)
                        .padding(.trailing, film.id == self.films.last!.id ? 14 : 0)
                    }
                }
            }
        }
        
    }
}

struct FilmPosterCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        FilmPosterCarouselView(filmTitle: "Now Playing", films: Film.getFilms)
    }
}
