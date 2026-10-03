//
//  AppRouter.swift
//  Untitled Project
//
//  Created by Aleksandra Iljina on 03/10/2026.
//

import SwiftUI

struct AppRouter {
    @ViewBuilder
    func destination(for gif: Gif) -> some View {
        GifDetailView(gif: gif)
    }
}
