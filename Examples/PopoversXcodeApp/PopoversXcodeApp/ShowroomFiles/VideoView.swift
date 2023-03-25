//
//  VideoView.swift
//  PopoversXcodeApp
//
//  Created by A. Zheng (github.com/aheze) on 12/23/21.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import AVKit
import Popovers
import SwiftUI

struct VideoView: View {
    @State var present = false

    /// the latest anchor where the popover was located before dismissal
    @State var selectedAnchor: Popover.Attributes.Position.Anchor?

    var body: some View {
        Button {
            present = true
        } label: {
            ExampleShowroomRow(color: UIColor(hex: 0xF7AF46)) {
                HStack {
                    ExampleImage("play.rectangle.fill", color: UIColor(hex: 0xF7AF46))

                    Text("Video")
                        .fontWeight(.medium)
                }
            }
        }
        .popover(
            present: $present,
            attributes: {
                $0.sourceFrameInset = UIEdgeInsets(16)
                $0.position = .relative(
                    popoverAnchors: [
                        selectedAnchor ?? .bottomRight,
                        .bottomRight, /// it's ok if you have duplicates
                        .bottomLeft,
                        .topRight,
                        .topLeft,
                    ]
                )
                $0.presentation.animation = .spring(
                    response: 0.6,
                    dampingFraction: 0.7,
                    blendDuration: 1
                )

                if [.topLeft, .topRight].contains(selectedAnchor) {
                    $0.presentation.transition = .move(edge: .top).combined(with: .opacity)
                } else {
                    $0.presentation.transition = .move(edge: .bottom).combined(with: .opacity)
                }

                $0.dismissal.mode = [.tapOutside, .dragDown, .dragUp]
                $0.dismissal.dragDismissalProximity = -0.2 /// make sure the drag is pretty far

                $0.onContextChange = { context in
                    self.selectedAnchor = context.selectedAnchor
                }
            }
        ) {
            VideoViewPopover()
                .frame(width: 300, height: 200)
                .cornerRadius(12)
                .shadow(
                    color: Color(uiColor: .black.withAlphaComponent(0.5)),
                    radius: 10,
                    x: 0,
                    y: 2
                )
        }
    }
}

struct VideoViewPopover: View {
    var body: some View {
        VideoPlayer(
            player: AVPlayer(
                url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!
            )
        )
    }
}
