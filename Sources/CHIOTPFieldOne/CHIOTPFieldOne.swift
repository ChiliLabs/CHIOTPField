//
//  CHIOTPFieldOne.swift
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

@IBDesignable
open class CHIOTPFieldOne: CHIOTPField<CHIOTPFieldOneLabel> {

    @IBInspectable
    public override var numberOfDigits: Int { didSet { redraw() } }

    @IBInspectable
    public override var spacing: Int { didSet { redraw() } }

    //background color of the box in normal state
    @IBInspectable
    public var boxBackgroundColor: UIColor = .white {
        didSet { redraw() }
    }

    //border color of the box in normal state
    @IBInspectable
    public var borderColor: UIColor = .lightGray {
        didSet { redraw() }
    }

    //corner radius of the box
    @IBInspectable
    public var cornerRadius: CGFloat = 0 {
        didSet { redraw() }
    }

    //shadow color of the box in active state
    @IBInspectable
    public var activeShadowColor: UIColor? = .lightGray {
        didSet { redraw() }
    }

    //shadow opacity of the box in active state
    @IBInspectable
    public var activeShadowOpacity: CGFloat = 0.4 {
        didSet { redraw() }
    }

    //placeholder text
    @IBInspectable
    public var boxPlaceholder: String? {
        didSet { redraw() }
    }

    //placeholder text color
    @IBInspectable
    public var boxPlaceholderColor: UIColor? = .lightGray {
        didSet { redraw() }
    }

    public override func redraw() {
        super.redraw()
        labels.forEach { (label) in
            label.layer.backgroundColor = boxBackgroundColor.cgColor
            label.borderColor = borderColor
            label.cornerRadius = cornerRadius
            label.activeShadowColor = activeShadowColor
            label.activeShadowOpacity = Float(activeShadowOpacity)
            label.placeholder = boxPlaceholder
            label.placeholderColor = boxPlaceholderColor
        }
    }
}
