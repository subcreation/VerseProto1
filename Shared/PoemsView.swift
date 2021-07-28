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
            .onDelete { index in
                viewModel.delete(at: index)
            }
        }
        .listStyle(SidebarListStyle())
        #if os(iOS)
        .navigationBarItems(trailing:
            Button {
                viewModel.isNavigationLinkActive = true
            } label: {
                Image(systemName: "plus")
                    .font(.title)
            })
        #else
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button(action: {
                    viewModel.isNavigationLinkActive = true
                }) {
                    Label("Add Item", systemImage: "square.and.pencil")
                }
            }
        }
        #endif
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
