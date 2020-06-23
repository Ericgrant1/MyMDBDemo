//
//  PosterCarouselView.swift
//  MyMDBDemo
//
//  Created by Eric Grant on 22.06.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import SwiftUI

struct PosterCarouselView: View {
    
    let filmTitle: String
    let films: [Film]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(filmTitle)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 14) {
                    ForEach(self.films) { film in
                        NavigationLink(destination: FilmDetailScreenView(filmID: film.id)) {
                            PosterBackgroundView(film: film)
                                .frame(width: 274, height: 210)
                        }
                    .buttonStyle(PlainButtonStyle())
                        .padding(.leading, film.id == self.films.first!.id ? 14 : 0)
                        .padding(.trailing, film.id == self.films.last!.id ? 14 : 0)
                    }
                }
            }
        }
    }
}

struct PosterCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        PosterCarouselView(filmTitle: "Latest", films: Film.getFilms)
    }
}
