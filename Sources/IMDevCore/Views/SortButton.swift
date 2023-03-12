//
//  SortButton.swift
//  
//
//  Created by Ike Mattice on 3/12/23.
//

import SwiftUI

/// A button that navigates to a sort menu
public struct SortButton<T: OptionMenuDataSource>: View {
    @Binding var sortSelection: T?

    public var body: some View {
        NavigationLink(
            destination: sortMenu) {
            Image(systemName: "slider.horizontal.3")
                .bold()
        }
    }

    @ViewBuilder
    var sortMenu: some View {
        List {
            OptionMenu(selection: $sortSelection)
        }
        .listStyle(.plain)
    }

    /// Creates a new ``SortButton``
    /// - Parameter sortSelection: The optional sort option that is currently selected, if any
    public init(sortSelection: Binding<T?>) {
        self._sortSelection = sortSelection
    }
}

// MARK: - Previews
struct SortButton_Previews: PreviewProvider {
    @State static var option: SortOption?

    static var previews: some View {
        SortButton(sortSelection: $option)
    }

    enum SortOption: OptionMenuDataSource {
        case option1
        case option2
        case option3
    }
}
