import SwiftUI
import SDWebImageSwiftUI
struct ContentView: View {
    @State private var searchText = ""
    @State private var gifs: [Gif] = []
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var hasSearched = false
    @State private var offset = 0
    @StateObject private var networkMonitor = NetworkMonitor()
    private let giphyService = GiphyService()
    private let router = AppRouter()
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
        
    ]
    var body: some View {
        NavigationStack {
            VStack {
                if !networkMonitor.isConnected {
                    Text("No Internet Connection")
                        .foregroundStyle(.red)
                        .padding(.horizontal)
                }
                TextField("Search GIFs...", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .task(id: searchText) {
                        guard !searchText.isEmpty else {
                            gifs = []
                            return
                        }
                        do {
                            isLoading = true
                            errorMessage = nil
                            hasSearched = true
                            offset = 0
                            try await
                            Task.sleep(for: .milliseconds(500))
                            gifs = try await
                            giphyService.searchGIFs(query:searchText)
                            isLoading = false
                        } catch is CancellationError {
                            //Search was cancelled because the user continued typing.
                        } catch {
                            isLoading = false
                            errorMessage = error.localizedDescription
                        }
                    }
                Text("You are searching for: \(searchText)")
                ScrollView {
                    if isLoading {
                        ProgressView()
                            .padding()
                    }
                    
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                            .padding()
                    }
                    
                    if hasSearched &&
                        !isLoading &&
                        gifs.isEmpty &&
                        errorMessage == nil {
                        Text("No GIFs found")
                            .foregroundStyle(.secondary)
                            .padding()
                    }
                    
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(gifs) { gif in
                            NavigationLink {
                                router.destination(for: gif)
                            } label: {
                                AnimatedImage(url: URL(string: gif.images.original.url))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 170)
                                    .clipped()
                                    .cornerRadius(10)
                            }
                            .task {
                                if gif.id == gifs.last?.id {
                                    await loadMore()
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Giphy Search")
        }
         
    }
    
    private func loadMore() async {
        guard !isLoading, !searchText.isEmpty else {
            return
        }
        
        isLoading = true
        offset += 20
        
        do {
            let newGifs = try await giphyService.searchGIFs(
                query: searchText,
                offset: offset
            )
            
            gifs.append(contentsOf: newGifs)
            isLoading = false
        } catch {
            isLoading = false
            errorMessage = error.localizedDescription
        }
        
    }
}
#Preview {
    ContentView()
}

