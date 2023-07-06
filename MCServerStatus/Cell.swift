//
//  Cell.swift
//  MCServerStatus
//
//  Created by Sudhip Nashi on 7/6/23.
//

import SwiftUI

struct Cell: View {
    @State var name: String
    @State var value: String
    
    var body: some View {
        HStack {
            Text(name)
            Spacer()
            Text(value).monospaced().foregroundColor(.gray)
        }
    }
}

struct Cell_Previews: PreviewProvider {
    static var previews: some View {
        Cell(name: "Test", value: "Value")
    }
}
