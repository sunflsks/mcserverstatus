//
//  ResultsView.swift
//  MCServerStatus
//
//  Created by Sudhip Nashi on 7/6/23.
//

import WebKit
import SwiftUI

struct ResultsView: View {
    @EnvironmentObject private var viewModel: ViewModel
    
    var body: some View {
        VStack {
            List {
                if viewModel.serverStatus == nil {
                    Section {
                        Text("Error fetching data!")
                    }
                }
                
                else if viewModel.serverStatus?.online == false {
                    Section {
                        Text("Currently Offline")
                    }
                }
                
                else {
                    Section {
                        Cell(name: "IP", value: (viewModel.serverStatus?.ip ?? "Unknown"))
                        Cell(name: "Port", value: (String(viewModel.serverStatus?.port ?? -1)))
                        if let hostname = viewModel.serverStatus?.hostname { Cell(name: "Hostname", value: hostname) }
                    } header: {
                        Text("Network Info")
                    }
                    
                    Section {
                        Cell(name: "Version", value: (viewModel.serverStatus?.version ?? "Unknown"))
                        if let software = viewModel.serverStatus?.software { Cell(name: "Software", value: software) }
                    } header: {
                        Text("Version Info")
                    }
                    
                    Section {
                        if let gamemode = viewModel.serverStatus?.gamemode { Cell(name: "Gamemode", value: gamemode) }
                        if let serverid = viewModel.serverStatus?.serverid { Cell(name: "Server ID", value: serverid) }
                        if let eula_blocked = viewModel.serverStatus?.eula_blocked { Cell(name: "Eula Blocked", value: String(eula_blocked)) }
                    } header: {
                        Text("Platform Specific Info")
                    }
                    
                    Section {
                        Cell(name: "Online", value: String(viewModel.serverStatus?.players.online ?? -1))
                        Cell(name: "Max", value: String(viewModel.serverStatus?.players.max ?? -1))
                    } header: {
                        Text("Player Info")
                    }
                    
                    if let players = viewModel.serverStatus?.players.list {
                        Section {
                            ForEach(players) { player in
                                Text(player)
                            }
                        } header: {
                            Text("Players")
                        }
                    }
                    
                    if let html = viewModel.serverStatus?.motd {
                        Section {
                            WebView(text: "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>" + html.html[0])
                        } header: {
                            Text("MOTD")
                        }
                    }
                }
            }
            .listStyle(.sidebar)
            .navigationTitle(viewModel.ip ?? "Unknown")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
    }
}

// needed for the Player section view; 99 percent of the time this is stupid and unsafe, and it still is, but there should not
// be any duplicate minecraft usernames, so it *should* work fine.
extension String: Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}
