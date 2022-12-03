//
//  ContentView.swift
//  NavigationStackDemo
//
//  Created by Julio Rico on 2/12/22.
//

import SwiftUI

struct Platform: Hashable {
    let name: String
    let imagenName: String
    let color: Color
}

struct Game: Hashable {
    let name: String
    let rating: String
}

extension Platform {
    static var examples: [Platform] {
        [
            .init(name: "Xbox", imagenName: "xbox.logo", color: .green),
            .init(name: "Playstation", imagenName: "playstation.logo", color: .indigo),
            .init(name: "Pc", imagenName: "pc", color: .red),
            .init(name: "Mobile", imagenName: "iphone", color: .mint)
            
        ]
    }
}

extension Game {
    static var examples: [Game] {
        [
            .init(name: "Minecraft", rating: "99"),
            .init(name: "God of War", rating: "98"),
            .init(name: "Fornite", rating: "97"),
            .init(name: "Batman", rating: "95")
        ]
    }
}

struct ContentView: View {
    var plaforms: [Platform] = Platform.examples
    var games: [Game] = Game.examples
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                Section("Platforms") {
                    ForEach(plaforms, id: \.name) { platform in
                        NavigationLink(value: platform) {
                            Label(platform.name, systemImage: platform.imagenName)
                                .foregroundColor(platform.color)
                        }
                    }
                }
                
                Section("Games") {
                    ForEach(games, id: \.name) { game in
                        NavigationLink(value: game) {
                            Text(game.name)
                        }
                    }
                }
            }
            .navigationTitle("Gaming")
            .navigationDestination(for: Platform.self) { platform in
                ZStack {
                    platform.color.ignoresSafeArea()
                    VStack {
                        Label(platform.name, systemImage: platform.imagenName)
                            .font(.largeTitle).bold()
                        List {
                            ForEach(games, id: \.name) { game in
                                NavigationLink(value: game) {
                                    Text(game.name)
                                }
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: Game.self) { game in
                VStack(spacing: 20) {
                    Text("\(game.name) - \(game.rating)")
                        .font(.largeTitle)
                    
                    Button("Recommended game") {
                        path.append(games.randomElement()!)
                    }
                    
                    Button("Go to another platform") {
                        path.append(plaforms.randomElement()!)
                    }
                    
                    Button("Go Home") {
                        path.removeLast(path.count)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
