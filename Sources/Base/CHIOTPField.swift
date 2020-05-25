//
//  CHIOTPField.swift
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
open class CHIOTPField<Label: POTPLabel>: UITextField, UITextFieldDelegate {

    @IBInspectable
    public var numberOfDigits: Int = 4 {
        didSet { redraw() }
    }

    @IBInspectable
    public var spacing: Int = 8 {
        didSet { redraw() }
    }

    public var labels: [Label] {
        return stackView.arrangedSubviews.compactMap({ $0 as? Label })
    }

    open override var text: String? {
        didSet {
            self.changeText(oldValue: oldValue, newValue: text)
        }
    }

    //private
    private lazy var stackView: UIStackView = {
        let s = UIStackView(frame: self.bounds)
        s.axis = .horizontal
        s.alignment = .fill
        s.distribution = .fillEqually
        s.isUserInteractionEnabled = false
        s.spacing = CGFloat(spacing)
        return s
    }()

    private var _textColor: UIColor?
    open override var textColor: UIColor? {
        didSet {
            if _textColor == nil {
                _textColor = oldValue
            }
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        textColor = .clear
        keyboardType = .numberPad
        borderStyle = .none

        if #available(iOS 12.0, *) {
            textContentType = .oneTimeCode
        }

        delegate = self
        addTarget(self, action: #selector(textChanged), for: .editingChanged)

        addSubview(stackView)
    }

    open override func setNeedsLayout() {
        super.setNeedsLayout()
        stackView.frame = bounds
    }

    open func redraw() {
        stackView.spacing = CGFloat(spacing)

        stackView.arrangedSubviews.forEach { (v) in
            stackView.removeArrangedSubview(v)
            v.removeFromSuperview()
        }

        for _ in 0 ..< self.numberOfDigits {
            let label = Label(frame: .zero)
            label.textColor = _textColor
            label.font = font
            label.isUserInteractionEnabled = false
            self.stackView.addArrangedSubview(label)
        }
    }

    private func updateFocus() {
        let focusIndex = text?.count ?? 0
        labels.enumerated().forEach { (i, label) in
            label.active = i == focusIndex
        }
    }

    private func removeFocus() {
        let focusIndex = text?.count ?? 0
        guard focusIndex < numberOfDigits else {
            return
        }
        labels[focusIndex].active = false
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard var text = self.text else {
            return false
        }

        if string.isEmpty, text.isEmpty == false {
            labels[text.count - 1].text = nil
            text.removeLast()
            self.text = text
            updateFocus()
            return false
        }

        return text.count < numberOfDigits
    }

    public func textFieldDidBeginEditing(_ textField: UITextField) {
        updateFocus()
    }

    @objc private func textChanged() {
        guard let text = text, text.count <= numberOfDigits else { return }

        labels.enumerated().forEach({ (i, label) in

            if i < text.count {
                let index = text.index(text.startIndex, offsetBy: i)
                let char = isSecureTextEntry ? "●" : String(text[index])
                label.text = char
            }
        })
        updateFocus()
    }

    private func changeText(oldValue: String?, newValue: String?) {
        guard let text = text, text.count <= numberOfDigits else { return }

        labels.enumerated().forEach({ (i, label) in

            if i < text.count {
                let index = text.index(text.startIndex, offsetBy: i)
                let char = isSecureTextEntry ? "●" : String(text[index])
                label.text = char
                label.updateState()
            }
        })
        if self.isFirstResponder {
            updateFocus()
        }
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        removeFocus()
    }

    open override func caretRect(for position: UITextPosition) -> CGRect {
        let index = self.text?.count ?? 0
        guard index < stackView.arrangedSubviews.count else {
            return .zero
        }

        let viewFrame = self.stackView.arrangedSubviews[index].frame
        let caretHeight = self.font?.pointSize ?? ceil(self.frame.height * 0.6)
        return CGRect(x: viewFrame.midX - 1, y: ceil((self.frame.height - caretHeight) / 2), width: 2, height: caretHeight)
    }
}
