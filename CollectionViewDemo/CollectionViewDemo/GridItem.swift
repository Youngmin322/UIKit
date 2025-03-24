//
//  GridItem.swift
//  CollectionViewDemo
//
//  Created by 조영민 on 3/24/25.
//

import Foundation

struct GridItem: Hashable {
    let id = UUID()
    let title: String
    let imageSystemName: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: GridItem, rhs: GridItem) -> Bool {
        return lhs.id == rhs.id
    }
}
