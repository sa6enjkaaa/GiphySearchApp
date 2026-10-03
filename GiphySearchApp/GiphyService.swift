//
//  GiphyService.swift
//  MyApp
//
//  Created by Aleksandra Iljina on 30/09/2026.
//

import Foundation
class GiphyService {
    
    func searchGIFs(query: String, offset: Int = 0) async throws -> [Gif] {
        
        let apiKey = "Bs6UhflwlnSt98BOoCQcaG8zEQODwLDk"
        
        let urlString = "https://api.giphy.com/v1/gifs/search?api_key=\(apiKey)&q=\(query)&limit=20&offset=\(offset)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(GiphyResponse.self, from: data)
        
        return response.data
        
    }
}
