//
//  String+Identifiable.swift
//  SwiftUI-List-Pagination
//
//  Created by Christian Elies on 04.08.19.
//  Copyright © 2019 Christian Elies. All rights reserved.
//

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
