//
//  OptionMenu.swift
//  
//
//  Created by Ike Mattice on 2/20/23.
//

import SwiftUI

/// Defines a object that can be used to drive a ``OptionMenu`` and conforms to the ``Labelable``, ``Hashable`` and ``CaseIterable`` protocols
public typealias OptionMenuDataSource = Hashable & CaseIterable & Labelable

/// A View that organizes a ``OptionMenuDataSource`` into a ``ForEach`` and can be presented as a menu that can select options
///
/// This View works best when powered by an enum that conforms to ``OptionMenuDataSource``, which most enums can conform to automatically.
///
/// It is also flexible to be used in a variety of ways, such as within a ``List``, ``VStack``, or ``HStack``
public struct OptionMenu<T: OptionMenuDataSource, CellContent: View>: View {
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
    let sortAction: ((any OptionMenuDataSource, any OptionMenuDataSource) -> Bool)

    /// All options contained in the ``MenuDataSource``
    var options: [T] {
        T.allCases.map { $0 }.sorted(by: sortAction)
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
            cellBuilder(option.label, selection == option)
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
            Text(option.label)
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
}

// MARK: - Init
extension OptionMenu {
    /// Creates a ``OptionMenu`` from the provided selection and a custom cell View
    /// - Parameters:
    ///   - selection: The selected option, if any
    ///   - sortedBy: An optional sorting method to apply to the results, if any, with a default of no sorting applied
    ///   - cellContent: A ViewBuilder that creates the cell content.  Provides a String to be used as the cell title, and a Bool to determine the state of the cell if selected or unselected
    public init(
        selection: Binding<T?>,
        sortedBy sortMethod: ((any OptionMenuDataSource, any OptionMenuDataSource) -> Bool)? = nil,
        cellContent: @escaping CellContentBuilder
    ) {
        self._selection = selection
        self.cellBuilder = cellContent
        self.sortAction = sortMethod ?? { _, _ in return true }
    }
}

extension OptionMenu where CellContent == EmptyView {
    /// Creates a ``OptionMenu`` from the provided selection using the default cell ViewBuilder
    /// - Parameters:
    ///  - selection: The selected option, if any
    ///  - sortedBy: An optional sorting method to apply to the results, if any, with a default of no sorting applied
    public init(
        selection: Binding<T?>,
        sortedBy sortMethod: ((any OptionMenuDataSource, any OptionMenuDataSource) -> Bool)? = nil
    ) {
        self._selection = selection
        self.sortAction = sortMethod ?? { _, _ in return true }
        self.cellBuilder = nil
    }
}

// MARK: - Previews
struct OptionMenu_Previews: PreviewProvider {
    @State static var selectedOption: Option? = .oneFinalOption

    static var previews: some View {
        List {
            OptionMenu(selection: $selectedOption)
        }
        .previewDisplayName("Default Cell in List")

        List {
            OptionMenu(
                selection: $selectedOption,
                sortedBy: { $0.label < $1.label })
        }
        .previewDisplayName("Alphabetical Sorted Menu in List")

        List {
            OptionMenu(selection: $selectedOption) { cellTitle, isSelected in
                customCell(titled: cellTitle, isSelected: isSelected)
            }
        }
        .previewDisplayName("Custom Cell in List")
    }
}

// MARK: Preview View Builders
extension OptionMenu_Previews {
    @ViewBuilder
    static func customCell(titled title: String, isSelected: Bool) -> some View {
        Text(title)
            .bold()
            .foregroundColor(isSelected ? .blue : .black)
    }
}

// MARK: Preview Options
extension OptionMenu_Previews {
    enum Option: CaseIterable, Labelable {
        case optionOne
        case another
        case oneFinalOption

        var label: String {
            String(describing: self).titleCased
        }
    }
}
