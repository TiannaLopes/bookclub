//
//  MyBookClubsView.swift
//  bookclub-ui
//
//  Created by Tianna Alina Lopes on 1/10/24.
//

import SwiftUI

struct MyBookClubsView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("My Book Clubs Page!")
        }
        .padding()
    }
}

struct MyBookClubsViews_Previews: PreviewProvider {
    static var previews: some View {
        MyBookClubsView()
    }
}
