//
//  CheckmarkToggleStyle.swift
//  IMDevCore
//
//  Created by Ike Mattice on 11/21/24.
//

import SwiftUI

import SFSafeSymbols

extension ToggleStyle where Self == CheckmarkToggleStyle {
    /// Checkmark toggle style available for iOS
    public static func checkmark(
        checkedImage: SFSymbol = .checkmarkSquare,
        uncheckedImage: SFSymbol = .square
    ) -> CheckmarkToggleStyle {
        CheckmarkToggleStyle(
            checkedImage: checkedImage,
            uncheckedImage: uncheckedImage)
    }
}

/// Checkmark toggle style available for iOS
public struct CheckmarkToggleStyle: ToggleStyle {
    let checkedImage: SFSymbol
    let uncheckedImage: SFSymbol

    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label

            Spacer()

            Image(systemSymbol: configuration.isOn ? .checkmarkSquare : .square)
                .resizable()
                .frame(width: 25, height: 25)
                .onTapGesture {
                    withAnimation(.spring()) {
                        configuration.isOn.toggle()
                    }
                }
        }
    }

    init(
        checkedImage: SFSymbol = .checkmarkSquare,
        uncheckedImage: SFSymbol = .square
    ) {
        self.checkedImage = checkedImage
        self.uncheckedImage = uncheckedImage
    }
}

// MARK: - Previews
#Preview("Checked") {
    Toggle("Checked", isOn: .constant(true))
        .toggleStyle(CheckmarkToggleStyle())
}

#Preview("Unchecked") {
    Toggle("Unchecked", isOn: .constant(false))
        .toggleStyle(CheckmarkToggleStyle())
}

#Preview("In List Context") {
    List {
        Toggle("Checked", isOn: .constant(true))
            .toggleStyle(CheckmarkToggleStyle())
        Toggle("Unchecked", isOn: .constant(false))
            .toggleStyle(CheckmarkToggleStyle())
        Toggle("Basic Toggle", isOn: .constant(true))
    }
}
