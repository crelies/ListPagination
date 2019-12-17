# ListPagination

[![Swift5](https://img.shields.io/badge/swift5-compatible-green.svg?longCache=true&style=flat-square)](https://developer.apple.com/swift)
[![Platform](https://img.shields.io/badge/platform-iOS%20%7C%20macOS%20%7C%20tvOS-lightgrey.svg?longCache=true&style=flat-square)](https://www.apple.com)
[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg?longCache=true&style=flat-square)](https://en.wikipedia.org/wiki/MIT_License)

This Swift package provides extensions of **RandomAccessCollection** which help you add pagination support to your **SwiftUI** `List view`. It is already integrated in my [AdvancedList view (Wrapper around SwiftUI's List view)](https://github.com/crelies/AdvancedList).

## Installation

Add this Swift package in Xcode using its Github repository url. (File > Swift Packages > Add Package Dependency...)

## How to use

You can add pagination with two different approaches to your `List`: **Last item approach** and **Threshold item approach**.

That's way this package adds two functions to **RandomAccessCollection**:

### isLastItem

Use this function to check if the item in the current `List item iteration` is the last item of your collection.

### isThresholdItem

With this function you can find out if the item of the current `List item iteration` is the item at your defined threshold.
Pass an offset (distance to the last item) to the function so the threshold item can be determined.

## Example

Both example code snippets below require a simple extension of **String**:

```swift
/*
    If you want to display an array of strings
    in the List view you have to specify a key path,
    so each string can be uniquely identified.
    With this extension you don't have to do that anymore.
 */
extension String: Identifiable {
    public var id: String {
        return self
    }
}
```

### Last item approach

```swift
struct ListPaginationExampleView: View {
    @State private var items: [String] = Array(0...24).map { "Item \($0)" }
    @State private var isLoading: Bool = false
    @State private var page: Int = 0
    private let pageSize: Int = 25
    
    var body: some View {
        NavigationView {
            List(items) { item in
                VStack(alignment: .leading) {
                    Text(item)
                    
                    if self.isLoading && self.items.isLastItem(item) {
                        Divider()
                        Text("Loading ...")
                            .padding(.vertical)
                    }
                }.onAppear {
                    self.listItemAppears(item)
                }
            }
            .navigationBarTitle("List of items")
            .navigationBarItems(trailing: Text("Page index: \(page)"))
        }
    }
}

extension ListPaginationExampleView {
    private func listItemAppears<Item: Identifiable>(_ item: Item) {
        if items.isLastItem(item) {
            isLoading = true
            
            /*
                Simulated async behaviour:
                Creates items for the next page and
                appends them to the list after a short delay
             */
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                self.page += 1
                let moreItems = self.getMoreItems(forPage: self.page, pageSize: self.pageSize)
                self.items.append(contentsOf: moreItems)
                
                self.isLoading = false
            }
        }
    }
}
```

### Threshold item approach

```swift
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
                    
                    if self.isLoading && self.items.isLastItem(item) {
                        Divider()
                        Text("Loading ...")
                            .padding(.vertical)
                    }
                }.onAppear {
                    self.listItemAppears(item)
                }
            }
            .navigationBarTitle("List of items")
            .navigationBarItems(trailing: Text("Page index: \(page)"))
        }
    }
}

extension ListPaginationThresholdExampleView {
    private func listItemAppears<Item: Identifiable>(_ item: Item) {
        if items.isThresholdItem(offset: offset,
                                 item: item) {
            isLoading = true
            
            /*
                Simulated async behaviour:
                Creates items for the next page and
                appends them to the list after a short delay
             */
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                self.page += 1
                let moreItems = self.getMoreItems(forPage: self.page, pageSize: self.pageSize)
                self.items.append(contentsOf: moreItems)
                
                self.isLoading = false
            }
        }
    }
}
```
