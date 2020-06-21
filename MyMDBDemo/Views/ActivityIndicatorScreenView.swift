//
//  ActivityIndicatorScreenView.swift
//  MyMDBDemo
//
//  Created by Eric Grant on 22.06.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation
import SwiftUI

struct ActivityIndicatorScreenView: UIViewRepresentable {
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {}
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let aiView = UIActivityIndicatorView(style: .large)
        aiView.startAnimating()
        return aiView
    }
}
