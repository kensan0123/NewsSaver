//
//  IntroPageView.swift
//  NewsSaver
//
//  Created by 中村健介 on 2025/06/11.
//

import SwiftUI

struct IntroPageView: View {
    let pageModel: IntroPageModel

    var body: some View {
        VStack {
            Text(pageModel.headerTitle)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.top, 20)
                .padding(.horizontal)
            Image(pageModel.imageName)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 550)
                .padding(.top, 20)
                .padding(.horizontal)
            Spacer()
        }
    }
}
