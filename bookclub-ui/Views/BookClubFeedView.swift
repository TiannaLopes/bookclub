//
//  BookClubFeedView.swift
//  bookclub-ui
//
//  Created by Tianna Alina Lopes on 1/10/24.
//

import SwiftUI

struct BookClubFeedView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("BookClub Feed Page!")
        }
        .padding()
    }
}

struct BookClubFeedView_Previews: PreviewProvider {
    static var previews: some View {
        BookClubFeedView()
    }
}
