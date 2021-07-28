//
//  EditPoemView.swift
//  EditPoemView
//
//  Created by Nathanael Roberton on 7/27/21.
//

import SwiftUI

struct EditPoemView: View {
    @StateObject var viewModel = EditPoemViewModel()
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            TextField("Enter Title (optional)", text: $viewModel.title)
                .font(.largeTitle)
            TextEditor(text: $viewModel.body)
                .font(.title2)
            Button {
                viewModel.createNewPoem()
                self.mode.wrappedValue.dismiss()
            } label: {
                Text("Save")
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(maxWidth: 350)
            }
            .tint(.blue)
            .buttonStyle(.bordered)
            .controlSize(.large)
            .controlProminence(.increased)
            .keyboardShortcut(.defaultAction)
        }
        .padding()
    }
}

struct EditPoemView_Previews: PreviewProvider {
    static var previews: some View {
        EditPoemView()
    }
}
