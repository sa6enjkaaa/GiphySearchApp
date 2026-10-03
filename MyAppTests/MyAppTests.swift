//
//  MyAppTests.swift
//  MyAppTests
//
//  Created by Aleksandra Iljina on 02/10/2026.
//

import Testing
@testable import MyApp

struct MyAppTests {

    @Test func gifModelCanBeCreated() {
        let gif = Gif(
            id: "1",
            title: "Test GIF",
            images: GifImages(
                original: GifImage(
                    url: "https://example.com/test.gif"
                )
            )
        )

        #expect(gif.id == "1")
        #expect(gif.images.original.url == "https://example.com/test.gif")
    }
}
