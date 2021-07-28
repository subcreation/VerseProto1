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
            TextField("Enter Title", text: $viewModel.title)
                .font(.largeTitle)
            TextEditor(text: $viewModel.body)
                .font(.title2)
        }
        .padding()
        .navigationBarItems(trailing:
            Button {
                self.mode.wrappedValue.dismiss()
            } label: {
                Text("Done")
            }
        )
        .onWillDisappear {
            if viewModel.poemIsStarted() {
                viewModel.createNewPoem()
            }
        }
    }
}

struct WillDisappearHandler: UIViewControllerRepresentable {
    func makeCoordinator() -> WillDisappearHandler.Coordinator {
        Coordinator(onWillDisappear: onWillDisappear)
    }

    let onWillDisappear: () -> Void

    func makeUIViewController(context: UIViewControllerRepresentableContext<WillDisappearHandler>) -> UIViewController {
        context.coordinator
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<WillDisappearHandler>) {
    }

    typealias UIViewControllerType = UIViewController

    class Coordinator: UIViewController {
        let onWillDisappear: () -> Void

        init(onWillDisappear: @escaping () -> Void) {
            self.onWillDisappear = onWillDisappear
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            onWillDisappear()
        }
    }
}

struct WillDisappearModifier: ViewModifier {
    let callback: () -> Void

    func body(content: Content) -> some View {
        content
            .background(WillDisappearHandler(onWillDisappear: callback))
    }
}

extension View {
    func onWillDisappear(_ perform: @escaping () -> Void) -> some View {
        self.modifier(WillDisappearModifier(callback: perform))
    }
}

struct EditPoemView_Previews: PreviewProvider {
    static var previews: some View {
        EditPoemView()
    }
}
