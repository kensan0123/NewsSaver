//
//  ContentView.swift
//  NewsSaver
//
//  Created by 中村健介 on 2025/06/03.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("My News", systemImage: "newspaper.fill") {
                NewsListView()
            }
            Tab("Account", systemImage: "person.crop.circle.fill") {
                ReviewCardView()
            }
        }
    }
}

#Preview {
    ContentView()
}
