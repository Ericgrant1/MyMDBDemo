//
//  BundleExtension.swift
//  MyMDBDemo
//
//  Created by Eric Grant on 21.06.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation

extension Bundle {
    
    func loadJSONDecod<T: Decodable>(jsonFile: String) throws -> T? {
        guard let url = self.url(forResource: jsonFile, withExtension: "json") else {
            return nil
        }
        let jsonData = try Data(contentsOf: url)
        let decoder = Utilities.jsonDecoder
        let decodedFile = try decoder.decode(T.self, from: jsonData)
        return decodedFile
    }
}
