//
//  CustomSegmentedControl.swift
//  TaskList
//
//  Created by Pinto Junior, William James on 29/04/22.
//

import UIKit
import RxSwift

class CustomSegmentedControl: UIView {
    // MARK: - Constants
    fileprivate let indexSelectedSubject = PublishSubject<Int>()
    
    // MARK: - Variables
    var indexSelectedSubjectObservable: Observable<Int> {
        return indexSelectedSubject.asObserver()
    }
    
    fileprivate var buttonTitles: [String] = []
    fileprivate var buttons: [ButtomCustom] = []
    
    fileprivate var selectorTextColor = UIColor(named: "Write")
    fileprivate var disableTextColor = UIColor(named: "Disabled")
    fileprivate var selectorViewColor = UIColor(named: "Text")
    fileprivate var disabeldViewColor = UIColor(named: "Backgroud")
    
    // MARK: - Actions
    @IBAction func buttonTapped(sender: UIButton) {
        for (indexButton, btn) in buttons.enumerated() {
            btn.setTitleColor(disableTextColor, for: .normal)
            btn.backgroundColor = disabeldViewColor
            
            if btn == sender {
                btn.setTitleColor(selectorTextColor, for: .normal)
                btn.backgroundColor = selectorViewColor
                self.indexSelectedSubject.onNext(indexButton)
            }
        }
    }
    
    // MARK: - Setup
    fileprivate func setupVC() {
        createButton()
        configStack()
    }
    
    // MARK: - Methods
    func setButtonTitles(buttonTitles: [String]) {
        self.buttonTitles = buttonTitles
        self.setupVC()
    }
    
    fileprivate func createButton() {
        self.buttons = [ButtomCustom]()
        self.buttons.removeAll()
        self.subviews.forEach({$0.removeFromSuperview()})
        for buttonTitle in buttonTitles {
            let button = ButtomCustom()
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor(disableTextColor, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
            button.backgroundColor = disabeldViewColor
            button.layer.cornerRadius = 15
            button.clipsToBounds = true
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            buttons.append(button)
        }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
        buttons[0].backgroundColor = selectorViewColor
    }
    
    fileprivate func configStack() {
        let stackBase = UIStackView(arrangedSubviews: buttons)
        stackBase.axis = .horizontal
        stackBase.spacing = 8
        stackBase.distribution = .fill
        stackBase.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stackBase)
        
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}

class ButtomCustom: UIButton {
    override var intrinsicContentSize: CGSize {
       get {
           let baseSize = super.intrinsicContentSize
           return CGSize(width: baseSize.width + 20,
                         height: baseSize.height)
           }
    }
}
