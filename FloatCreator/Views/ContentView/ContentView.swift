//
//  ContentView.swift
//
//  Created by Caleb Marquart on 2022-08-16.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: FloatInfoView(configuration: viewModel.configuration), isActive: $viewModel.showingNextView) {
                    EmptyView()
                }
                
                if UIDevice.current.userInterfaceIdiom == .phone {
                    PhoneEntryView(viewModel: viewModel)
                } else {
                    PadEntryView(viewModel: viewModel)
                }
            }
        }
        .navigationViewStyle(.stack)
        .fullScreenCover(isPresented: $viewModel.showingSettings) {
            SettingsView()
        }
        .fullScreenCover(isPresented: $viewModel.showingList) {
            ListView()
        }
        .alert("Are you sure you want to clear float?", isPresented: $viewModel.showingClearAlert) {
            Button("Clear", role: .destructive) {
                viewModel.clearFloat()
            }
            Button("Cancel", role: .cancel) {}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
