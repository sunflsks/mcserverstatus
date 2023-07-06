//
//  Utils.swift
//  MCServerStatus
//
//  Created by Sudhip Nashi on 7/6/23.
//

import SwiftUI
import Foundation

struct Players: Codable {
    let online: Int
    let max: Int
    let list: [String]?
}

struct MOTD : Codable {
    let raw: [String]
    let clean: [String]
    let html: [String]
}

struct ServerStatus : Codable {
    let online: Bool
    
    let ip: String
    let port: Int
    let hostname: String?
    
    let version: String
    let software: String?
    
    let gamemode: String?
    let serverid: String?
    let eula_blocked: Bool?
    
    let motd: MOTD?
    
    let players: Players
    
}

class ViewModel: ObservableObject {
    @Published private(set) var serverStatus: ServerStatus?
    @Published var ip: String?
    
    init() {
        Task.init {
            await fetchData()
        }
    }
    
    
    @MainActor
    func fetchData() async {
        guard let ip_unwrapped = ip, let url = URL(string: "https://api.mcsrvstat.us/2/" + ip_unwrapped) else {
            self.serverStatus = nil
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            self.serverStatus = try JSONDecoder().decode(ServerStatus.self, from: data)
        } catch {
            print("error: \(error)")
            self.serverStatus = nil
            return
        }
        
    }
}

