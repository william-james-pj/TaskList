//
//  PriorityButton.swift
//  TaskList
//
//  Created by Pinto Junior, William James on 29/04/22.
//

import UIKit
import RxSwift

class PriorityButton: UIView {
    // MARK: - Constants
    fileprivate let prioritySubject = PublishSubject<ETaskPriority>()
    
    // MARK: - Variables
    var prioritySubjectObservable: Observable<ETaskPriority> {
        return prioritySubject.asObserver()
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
        label.text = "Priority"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "Disabled")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let pullDownButton: UIButton = {
        let button = UIButton()
        button.showsMenuAsPrimaryAction = true
        
        button.setTitle("Basic", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.contentVerticalAlignment = .bottom
        button.contentHorizontalAlignment = .leading
        button.setTitleColor(UIColor(named: "White"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate lazy var basicAction = UIAction(title: "Basic") { _ in
        self.setButtonTitle(to: "Basic")
        self.prioritySubject.onNext(.basic)
    }
    
    fileprivate lazy var importantAction = UIAction(title: "Important") { _ in
        self.setButtonTitle(to: "Important")
        self.prioritySubject.onNext(.important)
    }
    
    fileprivate lazy var urgentAction = UIAction(title: "Urgent") { _ in
        self.setButtonTitle(to: "Urgent")
        self.prioritySubject.onNext(.urgent)
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
        
        pullDownButton.menu = UIMenu(title: "", children: [basicAction, importantAction, urgentAction])
        
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

