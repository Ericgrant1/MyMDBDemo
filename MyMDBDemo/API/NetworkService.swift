//
//  NetworkService.swift
//  MyMDBDemo
//
//  Created by Eric Grant on 20.06.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation

class NetworkService: FilmService {
    
    static let shared = NetworkService()
    private init() {}
    
    private let apiKey = "3ea764cc804c1157b6a32481ab478536"
    private let siteAPIURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utilities.jsonDecoder
    
    
    func fetchFilms(from endpoint: FilmListEndpoint,
                    completion: @escaping (Result<FilmResponse, FilmError>) -> ()) {
        guard let mdbURL = URL(string: "\(siteAPIURL)/movie/\(endpoint.rawValue)") else {
            completion(.failure(.unavailableEndpoint))
            return }
        self.loadDecodeUrl(url: mdbURL, completion: completion)
    }
    
    func fetchFilm(id: Int, completion: @escaping (Result<Film, FilmError>) -> ()) {
        guard let mdbURL = URL(string: "\(siteAPIURL)/movie/\(id)") else {
        completion(.failure(.unavailableEndpoint))
        return }
        self.loadDecodeUrl(url: mdbURL, parameters: ["append_to_response": "videos,credits"], completion: completion)
    }
    
    func searchFilm(query: String, completion: @escaping (Result<FilmResponse, FilmError>) -> ()) {
        guard let mdbURL = URL(string: "\(siteAPIURL)/search/movie/") else {
        completion(.failure(.unavailableEndpoint))
        return }
        self.loadDecodeUrl(url: mdbURL, parameters: [
            "language": "en-US",
            "include_adult": "false",
            "region": "US",
            "query": query
        ], completion: completion)
    }
    
    // MARK: - Helper Functions
    
    private func loadDecodeUrl<D: Decodable>(url: URL,
                                             parameters: [String: String]? = nil,
                                             completion: @escaping (Result<D, FilmError>) -> ()) {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.unavailableEndpoint))
            return
        }
        
        var requestItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let parameters = parameters {
            requestItems.append(contentsOf: parameters.map { URLQueryItem(name: $0.key, value: $0.value)})
        }
        
        urlComponents.queryItems = requestItems
        
        guard let resultURL = urlComponents.url else {
            completion(.failure(.unavailableEndpoint))
            return }
        
        urlSession.dataTask(with: resultURL) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if error != nil {
                self.performCompletionInMainThread(with: .failure(.apiError), completion: completion)
                return
            }
            
            guard let networkResponse = response as? HTTPURLResponse, 200..<300 ~= networkResponse.statusCode else {
                self.performCompletionInMainThread(with: .failure(.unavailableResponse), completion: completion)
                return
            }
            
            guard let networkData = data else {
                self.performCompletionInMainThread(with: .failure(.noData), completion: completion)
                return
            }
            
            do {
                let decodeNetworkResponse = try self.jsonDecoder.decode(D.self, from: networkData)
                self.performCompletionInMainThread(with: .success(decodeNetworkResponse), completion: completion)
            } catch {
                self.performCompletionInMainThread(with: .failure(.serialisationError), completion: completion)
            }
        }.resume()
    }
    
    private func performCompletionInMainThread<D: Decodable>(with result: Result<D, FilmError>,
                                                             completion: @escaping (Result<D, FilmError>) -> ()) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
