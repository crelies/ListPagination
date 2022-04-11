//
//  ContentView.swift
//  SwiftUI-List-Pagination
//
//  Created by Christian Elies on 04.08.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ListPaginationExampleView()
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
