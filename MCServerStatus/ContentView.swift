//
//  ContentView.swift
//  MCServerStatus
//
//  Created by Sudhip Nashi on 7/6/23.
//

import SwiftUI


struct ContentView: View {
    
    @State private var ipAddress: String = ""
    @State private var showingResultsView = false
    
    @StateObject var viewModel: ViewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    destination: ResultsView()
                        .environmentObject(viewModel), isActive: $showingResultsView) { EmptyView()
                    
                }
                
                Spacer()
                    .frame(height: 50)
                
                Text("Insert IP Address of MC Server")
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.black)
                
                TextField("IP Address", text: $ipAddress)
                    .onSubmit {
                        viewModel.ip = ipAddress
                        Task {
                            print("here")
                            await viewModel.fetchData()
                            showingResultsView = true
                        }
                    }
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .font(.body)
                    .monospaced()
                    .padding(20.0)
                    .background(RoundedRectangle(cornerRadius: 12, style: .circular).stroke(.gray, lineWidth: 2))
                    .padding()
                
                Spacer()
            }
            .multilineTextAlignment(.center)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
