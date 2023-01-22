//
//  ListView.swift
//  FloatCreator
//
//  Created by Caleb Marquart on 2023-01-11.
//

import SwiftUI

struct ListView: View {
    @StateObject var viewModel = ListViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.floats.isEmpty {
                    Text("There are no saved floats yet")
                        .font(.headline)
                        .offset(y: -60)
                } else {
                    List {
                        ForEach(viewModel.floats) { item in
                            NavigationLink {
                                viewModel.makeNavigationDestination(with: item)
                            } label: {
                                viewModel.makeNavigationLabel(with: item)
                            }

                        }
                        .onDelete(perform: viewModel.delete)
                    }
                }
            }
            .navigationTitle("Saved Floats")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }

                }
            }
            .task {
                await viewModel.fetchFloats()
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}


