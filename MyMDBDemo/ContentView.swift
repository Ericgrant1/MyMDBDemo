//
//  ContentView.swift
//  MyMDBDemo
//
//  Created by Eric Grant on 19.06.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            FilmListScreenView()
                .tabItem {
                    VStack {
                        Image(systemName: "tv")
                        Text("Films")
                    }
            }
            .tag(0)
            
            FilmSearchScreenView()
                .tabItem{
                    VStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
            }
            .tag(1)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
