//
//  FilmListScreenView.swift
//  MyMDBDemo
//
//  Created by Eric Grant on 22.06.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import SwiftUI

struct FilmListScreenView: View {
    
    @ObservedObject private var nowPlayingCondition = FilmListCondition()
    @ObservedObject private var upcomingCondition = FilmListCondition()
    @ObservedObject private var topRatedCondition = FilmListCondition()
    @ObservedObject private var popularCondition = FilmListCondition()
    
    var body: some View {
        NavigationView {
            List {
                Group {
                    if nowPlayingCondition.films != nil {
                        FilmPosterCarouselView(filmTitle: "Now Playing", films: nowPlayingCondition.films!)
                    } else {
                        ScreenLoadingView(download: nowPlayingCondition.downloading, error: nowPlayingCondition.error) {
                            self.nowPlayingCondition.loadFilms(with: .nowPlaying)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 18, leading: 0, bottom: 9, trailing: 0))
                
                Group {
                    if upcomingCondition.films != nil {
                        PosterCarouselView(filmTitle: "Upcoming", films: upcomingCondition.films!)
                    } else {
                        ScreenLoadingView(download: upcomingCondition.downloading, error: upcomingCondition.error) {
                            self.upcomingCondition.loadFilms(with: .upcoming)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 26, leading: 0, bottom: 9, trailing: 0))
                
                Group {
                    if topRatedCondition.films != nil {
                        PosterCarouselView(filmTitle: "Top Rated", films: topRatedCondition.films!)
                    } else {
                        ScreenLoadingView(download: topRatedCondition.downloading, error: topRatedCondition.error) {
                            self.topRatedCondition.loadFilms(with: .topRated)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 9, leading: 0, bottom: 9, trailing: 0))
                
                Group {
                    if popularCondition.films != nil {
                        PosterCarouselView(filmTitle: "Popular", films: popularCondition.films!)
                    } else {
                        ScreenLoadingView(download: popularCondition.downloading, error: popularCondition.error) {
                            self.popularCondition.loadFilms(with: .popular)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 9, leading: 0, bottom: 18, trailing: 0))
            }
            .navigationBarTitle("The MDB Demo")
        }
        .onAppear {
            self.nowPlayingCondition.loadFilms(with: .nowPlaying)
            self.upcomingCondition.loadFilms(with: .upcoming)
            self.topRatedCondition.loadFilms(with: .topRated)
            self.popularCondition.loadFilms(with: .popular)
        }
    }
}

struct FilmListScreenView_Previews: PreviewProvider {
    static var previews: some View {
        FilmListScreenView()
    }
}
