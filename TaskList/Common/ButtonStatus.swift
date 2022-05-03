//
//  ButtonStatus.swift
//  TaskList
//
//  Created by Pinto Junior, William James on 20/04/22.
//

import UIKit
import RxSwift

class ButtonStatus: UIView {
    // MARK: - Constants
    fileprivate let statusSubject = PublishSubject<ETaskStatus>()
    
    // MARK: - Variables
    var statusSubjectObservable: Observable<ETaskStatus> {
        return statusSubject.asObserver()
    }
    
    // MARK: - Components
    fileprivate let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let labelTitle: UILabel = {
        let label = UILabel()
        label.text = "Status"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "Disabled")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let pullDownButton: UIButton = {
        let button = UIButton()
        button.showsMenuAsPrimaryAction = true
        
        button.setTitle("To do", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.contentVerticalAlignment = .bottom
        button.contentHorizontalAlignment = .leading
        button.setTitleColor(UIColor(named: "White"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate lazy var toDoAction = UIAction(title: "To Do") { _ in
        self.setButtonTitle(to: "To do")
        self.statusSubject.onNext(.toDo)
    }
    
    fileprivate lazy var progressAction = UIAction(title: "In progress") { _ in
        self.setButtonTitle(to: "In progress")
        self.statusSubject.onNext(.progress)
    }
    
    fileprivate func setButtonTitle(to text: String) {
        self.pullDownButton.setTitle(text, for: .normal)
    }
    
    // MARK: - Init
    public init() {
        super.init(frame: .zero)
        setupV()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupV()
    }
    
    // MARK: - Setup
    fileprivate func setupV() {
        self.backgroundColor = UIColor(named: "Text")
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        
        pullDownButton.menu = UIMenu(title: "", children: [toDoAction, progressAction])
        
        buildHierarchy()
        buildConstraints()
    }

    // MARK: - Methods
    fileprivate func buildHierarchy() {
        self.addSubview(stackBase)
        stackBase.addArrangedSubview(pullDownButton)
        self.addSubview(labelTitle)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: self.topAnchor),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            
            labelTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            labelTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            self.heightAnchor.constraint(equalToConstant: 70),
            self.widthAnchor.constraint(equalToConstant: 140),
        ])
    }
}
