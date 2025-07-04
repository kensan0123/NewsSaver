//
//  AccountListView.swift
//  NewsSaver
//
//  Created by 中村健介 on 2025/06/12.
//

import SwiftUI

struct AccountListView: View {
    @State private var navigateToIntro = false
    var body: some View {
        NavigationStack {
            VStack {
                MainTopBar(title: "Account", showBackButton: false, onDocTapped: { navigateToIntro.toggle() })
                    .padding(.top)
                Spacer()
                HStack {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:100, height: 100)
                        .foregroundStyle(.black)
                }
                List {
                    NavigationLink("１週間の振り返り") {
                        ReviewCardView()
                    }
                }
            }
            .navigationDestination(isPresented: $navigateToIntro){
                IntroListView()
            }
        }
    }
}

#Preview {
    AccountListView()
}
