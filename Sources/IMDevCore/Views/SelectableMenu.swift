//
//  SelectableMenu.swift
//  
//
//  Created by Ike Mattice on 2/20/23.
//

import SwiftUI

/// Defines a object that can be used to drive a ``SelectableMenu`` and conforms to both ``Hashable`` and ``CaseIterable`` protocols
public typealias MenuDataSource = Hashable & CaseIterable

/// A View that organizes a ``MenuDataSource`` into a ``ForEach`` and can be presented as a menu that can select options
///
/// This View works best when powered by an enum that conforms to ``MenuDataSource``, which most enums can conform to automatically.
///
/// It is also flexible to be used in a variety of ways, such as within a ``List``, ``VStack``, or ``HStack``
public struct SelectableMenu<T: MenuDataSource, CellContent: View>: View {
    /// Defines a ``String`` that is used to title the cell ViewBuilder
    public typealias CellTitle = String
    /// Defines a ``Bool`` that is used to determine if the cell is selected
    public typealias isSelected = Bool
    /// Defines a function that builds a view using a ``CellTitle`` and a ``isSelected`` properties
    public typealias CellContentBuilder = ((CellTitle, isSelected)->CellContent)
    /// The value that is currently selected
    @Binding var selection: T?
    /// A function that creates the view used as the cells
    let cellBuilder: CellContentBuilder?

    /// All options contained in the ``MenuDataSource``
    var options: [T] {
        T.allCases.map { $0 }
    }

    public var body: some View {
        ForEach(options, id: \.self) { model in
            cellContent(for: model)
                .onTapGesture {
                    didTapCell(for: model)
                }
        }
    }

    /// Determines if the cell content is provided, or if the default cell builder should be used
    @ViewBuilder
    private func cellContent(for option: T) -> some View {
        if let cellBuilder {
            cellBuilder(cellTitle(for: option), selection == option)
        } else {
            defaultCell(for: option)
        }
    }

    /// A default cell used if no cell builder is provided
    @ViewBuilder
    private func defaultCell(for option: T) -> some View {
        HStack {
            Image(systemName: "checkmark")
                .opacity(option == selection ? 1 : 0)
            Text(String(describing: option).titleCased)
            Spacer()
        }
        .padding()
    }


    /// Toggles a cell option as the selected option
    /// - Parameter option: The option to consider
    private func didTapCell(for option: T?) {
        if selection == option {
            selection = nil
        } else {
            selection = option
        }
    }

    /// Converts the given option to a title cased label to use in the cell
    /// - Parameter option: The option to consider
    private func cellTitle(for option: T) -> String {
        String(describing: option).titleCased
    }
}

// MARK: - Init
extension SelectableMenu {
    /// Creates a ``SelectableMenu`` from the provided selection and a custom cell View
    /// - Parameters:
    ///   - selection: The selected option, if any
    ///   - cellContent: A ViewBuilder that creates the cell content.  Provides a String to be used as the cell title, and a Bool to determine the state of the cell if selected or unselected
    public init(
        selection: Binding<T?>,
        cellContent: @escaping CellContentBuilder) {
        self._selection = selection
        self.cellBuilder = cellContent
    }
}

extension SelectableMenu where CellContent == EmptyView {
    /// Creates a ``SelectableMenu`` from the provided selection using the default cell ViewBuilder
    /// - Parameter selection: The selected option, if any
    public init(selection: Binding<T?>) {
        self._selection = selection
        self.cellBuilder = nil
    }
}

// MARK: - Previews
struct SelectableMenu_Previews: PreviewProvider {
    @State static var selectedOption: Option? = .oneFinalOption

    static var previews: some View {
        defaultCellInList

        customCellInList
    }
}

// MARK: Preview View Builders
extension SelectableMenu_Previews {
    @ViewBuilder
    static var defaultCellInList: some View {
        List {
            SelectableMenu(selection: $selectedOption)
        }
        .previewDisplayName("Default Cell in List")
    }

    @ViewBuilder
    static var customCellInList: some View {
        List {
            SelectableMenu(selection: $selectedOption) { cellTitle, isSelected in
                customCell(titled: cellTitle, isSelected: isSelected)
            }
        }
        .previewDisplayName("Custom Cell in List")
    }

    @ViewBuilder
    static func customCell(titled title: String, isSelected: Bool) -> some View {
        Text(title)
            .bold()
            .foregroundColor(isSelected ? .blue : .black)
    }
}

// MARK: Preview Options
extension SelectableMenu_Previews {
    enum Option: CaseIterable {
        case optionOne
        case another
        case oneFinalOption
    }
}
