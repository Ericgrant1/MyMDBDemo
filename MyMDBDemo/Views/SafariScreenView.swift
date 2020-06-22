//
//  SafariScreenView.swift
//  MyMDBDemo
//
//  Created by Eric Grant on 23.06.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation
import SafariServices
import SwiftUI

struct SafariScreenView: UIViewControllerRepresentable {
    
    let safariURL: URL
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let safariViewController = SFSafariViewController(url: self.safariURL)
        return safariViewController
    }
}
