//
//  FrameTaggedView.swift
//  PopoversPlaygroundsApp
//
//  Created by A. Zheng (github.com/aheze) on 12/23/21.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import Combine
import Popovers
import SwiftUI

struct FrameTaggedView: View {
    @State var present = false

    var body: some View {
        ExampleRow(
            image: "tag",
            title: "Frame-Tagged View",
            color: 0x68BB3D
        ) {
            present.toggle()
        }
        .frameTag("Frame-Tagged View")
        .popover(present: $present) {
            FrameTaggedPopover()
                .frame(maxWidth: 300)
        }
    }
}

struct FrameTaggedPopover: View {
    @State var savedFrame = CGRect.zero

    var body: some View {
        WindowReader { window in
            VStack(alignment: .leading) {
                Text(verbatim: "This is just a view with a saved frame: \(savedFrame).")

                Button {
                    savedFrame = window.frameTagged("Frame-Tagged View")
                } label: {
                    HStack {
                        ExampleImage("square.dashed", color: 0x68BB3D)
                        Text("Update saved frame")
                    }
                }
                .foregroundColor(Color(uiColor: UIColor(hex: 0x68BB3D)))

                HStack {
                    ExampleImage.tip
                    Text("Tag a view to access its position and size from anywhere.")
                }

                HStack {
                    ExampleImage.warning
                    Text("Only use tagged frames for providing popovers' `excludedFrames` or `sourceFrame`. Avoid using them for anything else, due to State re-rendering issues.")
                }
            }
            .padding()
            .background(.background)
            .cornerRadius(12)
            .shadow(radius: 1)
        }
    }
}
