//
//  GifDetailView.swift
//  MyApp
//
//  Created by Aleksandra Iljina on 01/10/2026.
//

import SwiftUI
import SDWebImageSwiftUI

struct GifDetailView: View {
    let gif: Gif

    var body: some View {
        ScrollView {
            AnimatedImage(url: URL(string: gif.images.original.url))
                .resizable()
                .scaledToFit()
                .padding()
        }
        .navigationTitle("GIF")
        .navigationBarTitleDisplayMode(.inline)
    }
}
