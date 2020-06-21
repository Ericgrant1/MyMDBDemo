//
//  FilmPosterView.swift
//  MyMDBDemo
//
//  Created by Eric Grant on 22.06.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import SwiftUI

struct FilmPosterView: View {
    
    let film: Film
    @ObservedObject var posterLoader = PosterLoader()
    
    var body: some View {
        ZStack {
            if self.posterLoader.poster != nil {
                Image(uiImage: self.posterLoader.poster!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .shadow(radius: 4)
                
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .shadow(radius: 4)
                
                Text(film.title)
                    .multilineTextAlignment(.center)
            }
        }
    .frame(width: 206, height: 310)
        .onAppear {
            self.posterLoader.loadPoster(with: self.film.filmPosterURL)
        }
    }
}

struct FilmPosterView_Previews: PreviewProvider {
    static var previews: some View {
        FilmPosterView(film: Film.getFilm)
    }
}
