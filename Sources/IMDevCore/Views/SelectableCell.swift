//
//  SelectableCell.swift
//  
//
//  Created by Ike Mattice on 3/2/23.
//

import SwiftUI

/// A cell that displays a selection state
public struct SelectableCell: View {
    let title: String
    let isSelected: Bool

    public var body: some View {
        HStack {
            isSelectedImage

            Text(title)
                .bold(isSelected)
        }
    }

    @ViewBuilder
    var isSelectedImage: some View {
        ZStack {
            Image(systemName: "checkmark.circle.fill")
                .opacity(isSelected ? 1 : 0)
            Image(systemName: "circle")
                .opacity(isSelected ? 0 : 1)
        }
    }

    /// Creates a new ``SelectionCell``
    /// - Parameters:
    ///   - title: The title of the cell
    ///   - isSelected: Determines if the cell is in a selected state
    public init(title: String, isSelected: Bool) {
        self.title = title
        self.isSelected = isSelected
    }
}

// MARK: - Previews
struct SelectionCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SelectableCell(
                title: "Hello World",
                isSelected: true)
            .previewDisplayName("Selected")

            SelectableCell(
                title: "Hello World",
                isSelected: false)
            .previewDisplayName("Unselected")
        }
        .previewLayout(.sizeThatFits)
    }
}
