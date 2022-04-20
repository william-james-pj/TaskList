//
//  TextFieldCustom.swift
//  TaskList
//
//  Created by Pinto Junior, William James on 05/04/22.
//

import UIKit

class TextFieldCustom: UITextField {
    // MARK: - Variables
    override var placeholder: String? {
        didSet {
            self.setPlaceholder()
        }
    }
    
    // MARK: - Init
    public init() {
        super.init(frame: .zero)
        setupTextField()
        setupConstraint()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTextField()
        setupConstraint()
    }
    
    // MARK: - Setup
    fileprivate func setupTextField() {
        self.backgroundColor = .clear
//        self.layer.cornerRadius = 8
//        self.clipsToBounds = true
//        self.font = UIFont(name: "Roboto-Regular", size: 14)
        self.textColor = UIColor(named: "Text")
        
        setLeftPaddingPoints(0)
        setRightPaddingPoints(0)
    }
    
    fileprivate func setupConstraint() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // MARK: - Methods
    fileprivate func setPlaceholder() {
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Disabled") ?? .lightGray])
    }
    
    fileprivate func setLeftPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    fileprivate func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }

}
