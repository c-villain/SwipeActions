//
//  ExampleViewModel.swift
//  SwipeExample
//
//  Created by aromanov on 30.05.2022.
//

import SwiftUI

struct CellItem: Identifiable {
    let id = UUID()
    var number: Int
    var isHidden: Bool
}

class ExampleViewModel: ObservableObject {
    @Published var array: [CellItem] = [
        CellItem(number: 0, isHidden: false),
        CellItem(number: 1, isHidden: false),
        CellItem(number: 2, isHidden: false),
        CellItem(number: 3, isHidden: false),
        CellItem(number: 4, isHidden: false),
        CellItem(number: 5, isHidden: false)
    ]
    
    func hide(_ cell: CellItem) {
        if let index = array.firstIndex(where: { $0.id == cell.id }) {
            array[index].isHidden = true
        }
    }
}
