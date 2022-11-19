//
//  BlurView.swift
//  Gametopia
//
//  Created by Patricia Fiona on 19/11/22.
//

import Foundation
import SwiftUI

struct BlurView: UIViewRepresentable {

  func makeUIView(
    context: UIViewRepresentableContext<BlurView>
  ) -> UIView {
    let view = UIView()
    view.backgroundColor = .clear
    let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
    let blurView = UIVisualEffectView(effect: blurEffect)
    blurView.translatesAutoresizingMaskIntoConstraints = false
    view.insertSubview(blurView, at: 0)
    NSLayoutConstraint.activate([
      blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
      blurView.widthAnchor.constraint(equalTo: view.widthAnchor)
    ])
    return view
  }

  func updateUIView(
    _ uiView: UIView,
    context: UIViewRepresentableContext<BlurView>
  ) {}

}
