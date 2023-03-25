//
//  MenuView.swift
//  PopoversExample
//
//  Created by A. Zheng (github.com/aheze) on 12/23/21.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import Popovers
import SwiftUI

struct MenuView: View {
    @State var present = false
    @State var iconName = "list.bullet"
    @State var buttonDisabled = true

    var body: some View {
        Templates.Menu {
            Templates.DividedVStack {
                Templates.MenuButton(title: "Change Icon To List", systemImage: "list.bullet") {
                    iconName = "list.bullet"
                }
                Templates.MenuButton(title: "Change Icon To Keyboard", systemImage: "keyboard") {
                    iconName = "keyboard"
                }
                Templates.MenuButton(title: "Change Icon To Bag", systemImage: "bag") {
                    iconName = "bag"
                }
                Templates.MenuButton(title: "Disabled button", systemImage: "xmark.circle") {
                    iconName = "xmark.circle"
                }
                .disabled(buttonDisabled) /// Disable this button.
            }
        } label: { fade in
            ExampleShowroomRow(color: UIColor(hex: 0xFF00AB)) {
                HStack {
                    ExampleImage(iconName, color: UIColor(hex: 0xFF00AB))

                    Text("Menu")
                        .fontWeight(.medium)
                }
            }
            .opacity(fade ? 0.5 : 1)
        }
    }
}
