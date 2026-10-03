//
//  GIF.swift
//  MyApp
//
//  Created by Aleksandra Iljina on 30/09/2026.
//

import Foundation

struct Gif: Identifiable, Codable {
    let id: String
    let title: String
    let images: GifImages
}

struct GiphyResponse: Codable {
    let data: [Gif]
}
struct GifImages: Codable {
    let original: GifImage
    
enum CodingKeys: String, CodingKey {
    case original
}
}

struct GifImage: Codable {
    let url: String
}
