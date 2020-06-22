//
//  Film.swift
//  MyMDBDemo
//
//  Created by Eric Grant on 20.06.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation

struct Film: Decodable, Identifiable {
    
    let id: Int
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    let runtime: Int?
    let releaseDate: String?
    
    let genres: [FilmGenre]?
    let credits: FilmCredit?
    
    static private let dateFormat: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy"
        return df
    }()
    
    static private let duration: DateComponentsFormatter = {
        let duration = DateComponentsFormatter()
        duration.unitsStyle = .full
        duration.allowedUnits = [.hour, .minute]
        return duration
    }()
    
    var backgroundURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    
    var filmPosterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    var genreText: String {
        genres?.first?.name ?? "n/a"
    }
    
    var filmRating: String {
        let rating = Int(voteAverage)
        let filmRating = (0..<rating).reduce("") { (result, _) -> String in
            return result + "⭐️"
        }
        return filmRating
    }
    
    var filmScore: String {
        guard filmRating.count > 0 else {
            return "n/a"
        }
        return "\(filmRating.count)/10"
    }
    
    var filmDate: String {
        guard let filmRealeseDate = self.releaseDate, let date = Utilities.dateFormatter.date(from: filmRealeseDate) else {
            return "n/a"
        }
        return Film.dateFormat.string(from: date)
    }
    
    var filmDuration: String {
        guard let timePeriod = self.runtime, timePeriod > 0 else {
            return "n/a"
        }
        return Film.duration.string(from: TimeInterval(timePeriod) * 60) ?? "n/a"
    }

    var filmCast: [FilmCast]? {
        credits?.cast
    }
    
    var filmCrew: [FilmCrew]? {
        credits?.crew
    }
    
    var filmDirectors: [FilmCrew]? {
        filmCrew?.filter { $0.job.lowercased() == "director" }
    }
    
    var filmProducers: [FilmCrew]? {
        filmCrew?.filter { $0.job.lowercased() == "producer" }
    }
    
    var filmWriters: [FilmCrew]? {
        filmCrew?.filter { $0.job.lowercased() == "writer" }
    }
}

