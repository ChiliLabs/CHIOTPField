//
//  CHIOTPFieldThreeLabel.swift
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

final public class CHIOTPFieldThreeLabel: UIView, POTPLabel {
    public var textColor: UIColor! {
        didSet { redraw() }
    }

    public var text: String?

    public var font: UIFont!

    public var active = false {
        didSet {
            updateActive(oldValue: oldValue, newValue: active)
        }
    }

    var dotRadius: CGFloat = 8 {
        didSet { redraw() }
    }

    var borderHeight: CGFloat = 2 {
        didSet { redraw() }
    }

    var borderCornerRadius: CGFloat = 0 {
        didSet { redraw() }
    }

    private let animatedShape: CAShapeLayer

    private var borderPath: CGPath {
        let borderFrame = CGRect(x: 0, y: self.frame.height - borderHeight, width: self.frame.width, height: borderHeight)
        return UIBezierPath(roundedRect: borderFrame, cornerRadius: borderCornerRadius).cgPath
    }

    private var filledPath: CGPath {
        let dotFrame = CGRect(x: self.frame.width / 2 - dotRadius, y: self.frame.height / 2 - dotRadius, width: dotRadius * 2, height: dotRadius * 2)
        return UIBezierPath(roundedRect: dotFrame, cornerRadius: dotRadius).cgPath
    }

    override init(frame: CGRect) {
        self.animatedShape = CAShapeLayer()
        super.init(frame: frame)
        self.layer.addSublayer(animatedShape)
        self.clipsToBounds = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func updateState() {}

    public override func layoutSubviews() {
        super.layoutSubviews()
        self.animatedShape.path = self.text != nil ? filledPath : borderPath
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
        self.animatedShape.fillColor = textColor.cgColor
        self.animatedShape.path = text != nil ? filledPath : borderPath
    }

    private func startAnimation() {
        guard let animation = self.animatedShape.animation(forKey: "animation") as? CABasicAnimation else {
            return
        }
        self.superview?.bringSubviewToFront(self)
        self.animatedShape.removeAllAnimations()
        let basicAnimation = CABasicAnimation(keyPath: "path")
        basicAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        basicAnimation.fromValue = animation.toValue
        basicAnimation.toValue = self.borderPath
        basicAnimation.duration = 0.1
        basicAnimation.isRemovedOnCompletion = true
        basicAnimation.fillMode = .forwards
        self.animatedShape.add(basicAnimation, forKey: "animation")

    }

    private func stopAnimation() {
        let basicAnimation = CABasicAnimation(keyPath: "path")
        basicAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        basicAnimation.fromValue = self.animatedShape.path
        basicAnimation.toValue = self.text != nil ? self.filledPath : self.borderPath
        basicAnimation.duration = 0.2
        basicAnimation.isRemovedOnCompletion = false
        basicAnimation.fillMode = .forwards
        self.animatedShape.add(basicAnimation, forKey: "animation")
    }
}
