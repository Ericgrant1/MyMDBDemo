//
//  FilmSearchBarView.swift
//  MyMDBDemo
//
//  Created by Eric Grant on 23.06.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation
import SwiftUI

struct FilmSearchBarView: UIViewRepresentable {
    
    let filmPlaceholder: String
    @Binding var filmText: String
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = filmText
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        let filmSearchBar = UISearchBar(frame: .zero)
        filmSearchBar.placeholder = filmPlaceholder
        filmSearchBar.searchBarStyle = .minimal
        filmSearchBar.enablesReturnKeyAutomatically = false
        filmSearchBar.delegate = context.coordinator
        return filmSearchBar
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: self.$filmText)
    }
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var filmText: String
        init(text: Binding<String>) {
            _filmText = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            self.filmText = searchText
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
    }
}
