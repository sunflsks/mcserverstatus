//
//  ResultsView.swift
//  MCServerStatus
//
//  Created by Sudhip Nashi on 7/6/23.
//

import SwiftUI

struct ResultsView: View {
    @EnvironmentObject private var viewModel: ViewModel
    
    var body: some View {
        Text(viewModel.serverStatus?.ip ?? "Loading")
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
    }
}
