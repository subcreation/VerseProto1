//
//  PoemsView.swift
//  PoemsView
//
//  Created by Nathanael Roberton on 7/27/21.
//

import SwiftUI

struct PoemsView: View {
    @StateObject var viewModel = PoemsViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.poems) { poem in
                Text(poem.title ?? "Unknown Title")
            }
        }
        .navigationBarItems(trailing:
            Button {
                viewModel.isNavigationLinkActive = true
            } label: {
                Image(systemName: "plus")
                    .font(.title)
            })
        .background(
            NavigationLink(destination: EditPoemView(), isActive: $viewModel.isNavigationLinkActive) {
                EmptyView()
            }
                .hidden()
        )
        .onAppear {
            viewModel.fetchAllPoems()
        }
    }
}

struct PoemsView_Previews: PreviewProvider {
    static var previews: some View {
        PoemsView()
    }
}
