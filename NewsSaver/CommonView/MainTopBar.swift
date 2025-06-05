//
//  MainTopBar.swift
//  NewsSaver
//
//  Created by 中村健介 on 2025/06/04.
//

import SwiftUI

struct MainTopBar: View {
    var title: String
    var showBackButton: Bool = false
    var showSearchButton: Bool = false
    var onBackTapped: (() -> Void)? = nil
    var onSearchTapped: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            if showBackButton {
                Button(action: {
                    onBackTapped?()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.white)
                        .padding(.leading)
                }
            } else {
                Image(systemName: "doc.text")
                    .foregroundStyle(.white)
                    .padding(.leading)
            }
            
            Spacer()
            Text(title)
                .foregroundColor(.white)
                .font(.headline)
            Spacer()
            if showSearchButton {
                Button(action: {
                    onSearchTapped?()
                }) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.white)
                        .padding(.trailing)
                }
            } else {
                Image(systemName: "person")
                    .opacity(0)
                    .padding(.trailing)
            }
        }
        .frame(height: 44)
        .frame(maxWidth: .infinity)
        .background(Color.black)
    }
}
