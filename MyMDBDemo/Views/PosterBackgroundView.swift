//
//  PosterBackgroundView.swift
//  MyMDBDemo
//
//  Created by Eric Grant on 21.06.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import SwiftUI

struct PosterBackgroundView: View {
    
    let film: Film
    @ObservedObject var posterLoader = PosterLoader()
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                
                if self.posterLoader.poster != nil {
                    Image(uiImage: self.posterLoader.poster!)
                    .resizable()
                }
            }
            .aspectRatio(16/9, contentMode: .fit)
            .cornerRadius(10)
            .shadow(radius: 4)
            Text(film.title)
        }
        .lineLimit(1)
        .onAppear {
            self.posterLoader.loadPoster(with: self.film.backgroundURL)
        }
    }
}

struct PosterBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        PosterBackgroundView(film: Film.getFilm)
    }
}
