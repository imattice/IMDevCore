//  AccessibilityTextPreview.swift
//  IMDevCore
//
//  Created by Ike Mattice on 8/21/21.
//

import SwiftUI

/// Displays content given the selected dynamic sizes
public struct AccessibilityTextPreview<Content: View>: View {
    /// The views to display
    private let content: () -> Content
    /// The text sizes to display
    private let sizes: [DynamicTypeSize]

    public var body: some View {
        ForEach(sizes, id:\.self) { size in
            content()
                .dynamicTypeSize(size)
                .previewDisplayName("\(String(describing: size).capitalized) Text")
        }
    }

    public init(sizes: SizeOption = .standard, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.sizes = sizes.sizes
    }
}

// MARK: - Size Option Definition
extension AccessibilityTextPreview {
    /// Defines a standardized group of Dynamic types
    public enum SizeOption {
        /// An option for a standard group of text sizes
        case standard
        /// An option for all accessible text sizes
        case accessibility
        /// An option for all possible text sizes
        case all
        /// An option for a custom group of text sizes
        case custom([DynamicTypeSize])
        /// Returns a group of text sizes based on the current option
        var sizes: [DynamicTypeSize] {
            switch self {
            case .standard:
                return [
                    .small,
                    .medium,
                    .large,
                    .xxxLarge
                ]

            case .accessibility:
                return [
                    .accessibility1,
                    .accessibility2,
                    .accessibility3,
                    .accessibility4,
                    .accessibility5
                ]

            case .all:
                return DynamicTypeSize.allCases

            case .custom(let sizes):
                return sizes
            }
        }
    }
}

// MARK: - Previews
struct AccessibilityTextPreview_Previews: PreviewProvider {
    static var previews: some View {
        AccessibilityTextPreview {
            Text("Test Text")
                .previewLayout(.sizeThatFits)
        }
    }
}
