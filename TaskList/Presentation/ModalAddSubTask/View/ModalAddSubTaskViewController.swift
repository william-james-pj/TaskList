//
//  ModalAddSubTaskViewController.swift
//  TaskList
//
//  Created by Pinto Junior, William James on 05/04/22.
//

import UIKit
import RxSwift

class ModalAddSubTaskViewController: UIViewController {
    // MARK: - Constants
    fileprivate let subTaskSubject = PublishSubject<SubTaskModel>()
    
    // MARK: - Variables
    var subTaskSubjectObservable: Observable<SubTaskModel> {
        return subTaskSubject.asObserver()
    }
    
    // MARK: - Components
    fileprivate let viewBase: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(named: "Backgroud")
        uiView.layer.cornerRadius = 10
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    fileprivate let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 32
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let viewStackAux: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let labelTitle: UILabel = {
        let label = UILabel()
        label.text = "Creat subtask"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate func stackHeader() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(labelTitle)
        return stack
    }
    
    fileprivate let textFieldTitle: TextFieldCustom = {
        let textField = TextFieldCustom()
        textField.placeholder = "Subtask name"
        textField.font = UIFont(name: "Roboto-Regular", size: 22)
        return textField
    }()
    
    fileprivate let textFieldDescription: TextFieldCustom = {
        let textField = TextFieldCustom()
        textField.placeholder = "Add description..."
        textField.font = UIFont(name: "Roboto-Regular", size: 14)
        return textField
    }()
    
    fileprivate func stackForm() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(textFieldTitle)
        stack.addArrangedSubview(textFieldDescription)
        return stack
    }
    
    fileprivate lazy var buttonCancel: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(UIColor(named: "Disabled"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var buttonDone: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "Text")
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(UIColor(named: "Backgroud"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        return button
    }()
    
    fileprivate func stackFooter() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(buttonCancel)
        stack.addArrangedSubview(buttonDone)
        return stack
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    // MARK: - Setup
    fileprivate func setupVC() {
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Action
    @IBAction func cancelButtonTapped() -> Void {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func doneButtonTapped() -> Void {
        guard let title = textFieldTitle.text, !title.isEmpty else {
            return
        }
        
        let newSubtask = SubTaskModel(title: title, isComplet: false)
        subTaskSubject.onNext(newSubtask)
        
        dismiss(animated: false, completion: nil)
    }
    
    // MARK: - Methods
    fileprivate func buildHierarchy() {
        view.addSubview(viewBase)
        viewBase.addSubview(stackBase)
        stackBase.addArrangedSubview(stackHeader())
        stackBase.addArrangedSubview(stackForm())
        stackBase.addArrangedSubview(viewStackAux)
        stackBase.addArrangedSubview(stackFooter())
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            viewBase.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewBase.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewBase.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            viewBase.heightAnchor.constraint(equalToConstant: 350),
            
            stackBase.topAnchor.constraint(equalTo: viewBase.safeAreaLayoutGuide.topAnchor, constant: 32),
            stackBase.leadingAnchor.constraint(equalTo: viewBase.leadingAnchor, constant: 32),
            stackBase.trailingAnchor.constraint(equalTo: viewBase.trailingAnchor, constant: -32),
            stackBase.bottomAnchor.constraint(equalTo: viewBase.bottomAnchor, constant: -40),
            
            buttonCancel.widthAnchor.constraint(equalToConstant: 70),
            buttonDone.widthAnchor.constraint(equalToConstant: 70),
        ])
    }

}
