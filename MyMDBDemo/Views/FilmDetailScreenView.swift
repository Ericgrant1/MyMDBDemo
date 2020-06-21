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
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct FilmDetailScreenView_Previews: PreviewProvider {
    static var previews: some View {
        FilmDetailScreenView(filmID: Film.getFilm.id)
    }
}
