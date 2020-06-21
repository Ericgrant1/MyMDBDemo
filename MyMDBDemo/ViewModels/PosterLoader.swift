//
//  PosterLoader.swift
//  MyMDBDemo
//
//  Created by Eric Grant on 21.06.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

private let posterCache = NSCache<AnyObject, AnyObject>()

class PosterLoader: ObservableObject {
    
    @Published var poster: UIImage?
    @Published var downloading = false
    
    var imagePosterCache = posterCache
    
    func loadPoster(with url: URL) {
        let urlImage = url.absoluteString
        if let posterFromCache = posterCache.object(forKey: urlImage as AnyObject) as? UIImage {
            self.poster = posterFromCache
            return
        }
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            do {
                let posterData = try Data(contentsOf: url)
                guard let poster = UIImage(data: posterData) else { return }
                self.imagePosterCache.setObject(poster, forKey: urlImage as AnyObject)
                DispatchQueue.main.async { [weak self] in
                    self?.poster = poster
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
