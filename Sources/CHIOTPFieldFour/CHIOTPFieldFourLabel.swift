//
//  CHIOTPFieldFourLabel.swift
//  CHIOTPField - https://github.com/ChiliLabs/CHIOTPField
//
//  Copyright © 2020 Chili Labs. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation
import UIKit

final public class CHIOTPFieldFourLabel: UIView, POTPLabel {
    public var text: String? {
        didSet { label.text = text }
    }

    public var font: UIFont! {
        didSet { label.font = font }
    }

    public var active = false {
        didSet {
            updateActive(oldValue: oldValue, newValue: active)
        }
    }

    var borderColor: UIColor? {
        didSet { redraw() }
    }

    var borderHeight: CGFloat = 2 {
        didSet { redraw() }
    }

    var cornerRadius: CGFloat = 0 {
        didSet { redraw() }
    }

    public var textColor: UIColor! {
        didSet {
            self.label.textColor = textColor
        }
    }

    private var animator = UIViewPropertyAnimator()
    private let label: UILabel
    private let bottomBorder = UIView()

    private var hasText: Bool {
        return self.text?.isEmpty == false
    }

    override init(frame: CGRect) {
        self.label = UILabel(frame: frame)
        super.init(frame: frame)
        self.addSubview(label)
        self.addSubview(bottomBorder)
        label.alpha = 0
        self.label.textAlignment = .center
        self.layer.masksToBounds = true
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        self.label.frame = self.bounds.offsetBy(dx: 0, dy: -borderHeight / 2)
        self.bottomBorder.frame = CGRect(x: 0, y: self.frame.height - borderHeight, width: self.frame.width, height: borderHeight)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func updateState() {
        self.stopAnimation()
    }

    private func updateActive(oldValue: Bool, newValue: Bool) {
        guard oldValue != newValue else { return }

        if newValue == true {
            self.startAnimation()
        } else {
            self.stopAnimation()
        }
    }

    private func redraw() {
        self.layer.cornerRadius = self.cornerRadius
        self.bottomBorder.backgroundColor = self.borderColor
    }

    private func startAnimation() {
        animator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.9, animations: {
            self.label.alpha = 0
        })
        animator.startAnimation()
    }

    private func stopAnimation() {
        animator.addAnimations {
            self.label.alpha = 1
        }
        animator.startAnimation()
    }
}
