//
//  CHIOTPFieldOneLabel.swift
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

final public class CHIOTPFieldOneLabel: UIView, POTPLabel {
    public var text: String? {
        didSet {
            label.text = text
        }
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

    var cornerRadius: CGFloat = 0 {
        didSet { redraw() }
    }

    var activeShadowColor: UIColor? {
        didSet { redraw() }
    }

    var placeholder: String? {
        didSet { redraw() }
    }

    var placeholderColor: UIColor? {
        didSet { redraw() }
    }

    var activeShadowOpacity: Float = 0

    public var textColor: UIColor! {
        didSet {
            self.label.textColor = textColor
        }
    }

    private var animator = UIViewPropertyAnimator()

    private let label: UILabel

    override init(frame: CGRect) {
        self.label = UILabel(frame: frame)
        super.init(frame: frame)
        self.addSubview(label)
        self.label.textAlignment = .center
        self.clipsToBounds = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func updateState() {
        self.stopAnimation()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        self.label.frame = self.bounds
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
        self.layer.borderColor = self.borderColor?.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = self.cornerRadius
        if let placeholder = placeholder {
            self.label.textColor = placeholderColor
            self.label.text = placeholder
        }
    }

    private func startAnimation() {
        animator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.9, animations: {
            self.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1)
            self.layer.borderColor = UIColor.clear.cgColor
            self.layer.shadowColor = self.activeShadowColor?.cgColor
            self.layer.shadowRadius = ceil(self.frame.height / 8)
            self.layer.shadowOpacity = self.activeShadowOpacity
            self.layer.shadowOffset = CGSize(width: 0, height: self.layer.shadowRadius / 2)
            self.label.textColor = self.textColor
            self.text = nil
        })
        animator.startAnimation()
    }

    private func stopAnimation() {
        animator.addAnimations {
            self.layer.transform = CATransform3DIdentity
            self.layer.borderColor = self.text?.isEmpty == false ? UIColor.clear.cgColor : self.borderColor?.cgColor
            self.layer.shadowColor = UIColor.clear.cgColor
            self.layer.shadowRadius = 0
            self.layer.shadowOpacity = 0
            if self.placeholder != nil {
                self.label.textColor = self.text != nil ? self.textColor : self.placeholderColor
            }
            self.text = self.text ?? self.placeholder
        }
        animator.startAnimation()
    }
}
