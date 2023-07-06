//
//  CachedAsyncImage.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 6.07.23.
//

import SwiftUI

struct CacheAsyncImage<Content>: View where Content: View  {
    private let url: URL
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content
    
    init(
        url: URL,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction(),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }
    
    
    var body: some View {
        if let cached = ImageCache[url] {
            let _ = print("cached \(url.absoluteString)")
            content(.success(cached))
        } else {
            let _ = print("request \(url.absoluteString)")
            AsyncImage(
                url: url,
                scale: scale,
                transaction: transaction
            ) { phase in
                cacheAndRender(phase: phase)
            }
        }
    }
    
    func cacheAndRender(phase: AsyncImagePhase) -> some View {
        if case .success(let image) = phase {
            ImageCache[url] = image
        }
        
        return content(phase)
    }
}

fileprivate class ImageCache {
    static private var cache: [URL: Image] = [:]
    
    static subscript(url: URL) -> Image? {
        get {
            ImageCache.cache[url]
        }
        set {
            ImageCache.cache[url] = newValue
        }
    }
}

struct ErrorView: View {
    let error: Error
    
    var body: some View {
        print(error)
        return Text("❌ **Error**").font(.system(size: 60))
    }
}

#Preview {
    CacheAsyncImage(
        url: URL(string: Constants.Api.imagesBaseUrl + Constants.Api.productsPath + "eyge8oisnfzrhqxvumom.png")!
    ) { phase in
        switch phase {
        case .empty:
            ProgressView()
        case .success(let image):
            image
        case .failure(let error):
            ErrorView(error: error)
        @unknown default:
            fatalError()
        }
    }
}
