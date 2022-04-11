//
//  ListPaginationThresholdExampleView.swift
//  SwiftUI-List-Pagination
//
//  Created by Christian Elies on 05.08.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

import ListPagination
import SwiftUI

struct ListPaginationThresholdExampleView: View {
    @State private var items: [String] = Array(0...24).map { "Item \($0)" }
    @State private var isLoading: Bool = false
    @State private var page: Int = 0
    private let pageSize: Int = 25
    private let offset: Int = 10

    var body: some View {
        NavigationView {
            List(items) { item in
                VStack(alignment: .leading) {
                    Text(item)

                    if isLoading && items.isLastItem(item) {
                        Divider()
                        ProgressView()
                    }
                }.onAppear {
                    listItemAppears(item)
                }
            }
            .navigationTitle("List of items")
            .toolbar {
                ToolbarItem {
                    Text("Page index: \(page)")
                }
            }
        }
    }
}

private extension ListPaginationThresholdExampleView {
    func listItemAppears<Item: Identifiable>(_ item: Item) {
        if items.isThresholdItem(
            offset: offset,
            item: item
        ) {
            isLoading = true

            /*
                Simulated async behaviour:
                Creates items for the next page and
                appends them to the list after a short delay
             */
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                page += 1
                let moreItems = getMoreItems(forPage: page, pageSize: pageSize)
                items.append(contentsOf: moreItems)
                isLoading = false
            }
        }
    }
}

private extension ListPaginationThresholdExampleView {
    /*
        In a real app you would probably fetch data
        from an external API.
     */
    func getMoreItems(
        forPage page: Int,
        pageSize: Int
    ) -> [String] {
        let maximum = ((page * pageSize) + pageSize) - 1
        let moreItems: [String] = Array(items.count...maximum).map { "Item \($0)" }
        return moreItems
    }
}

#if DEBUG
struct ListPaginationThresholdExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ListPaginationThresholdExampleView()
    }
}
#endif
