//
//  FilmSearchScreenView.swift
//  MyMDBDemo
//
//  Created by Eric Grant on 23.06.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import SwiftUI

struct FilmSearchScreenView: View {
    
    @ObservedObject var filmSearchCondition = FilmSearchCondition()
    
    var body: some View {
        NavigationView {
            List {
                FilmSearchBarView(filmPlaceholder: "Search films", filmText: self.$filmSearchCondition.request)
                .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                
                ScreenLoadingView(download: self.filmSearchCondition.downloading, error: self.filmSearchCondition.error) {
                    self.filmSearchCondition.searchCondition(request: self.filmSearchCondition.request)
                }
                
                if self.filmSearchCondition.films != nil {
                    ForEach(self.filmSearchCondition.films!) { film in
                        NavigationLink(destination: FilmDetailScreenView(filmID: film.id)) {
                            VStack(alignment: .leading) {
                                Text(film.title)
                                Text(film.filmDate)
                            }
                        }
                    }
                }
            }
            .onAppear {
                self.filmSearchCondition.startObserve()
            }
        .navigationBarTitle("Search")
        }
    }
}

struct FilmSearchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        FilmSearchScreenView()
    }
}
