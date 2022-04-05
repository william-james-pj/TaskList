//
//  ModalAddTaskViewController.swift
//  TaskList
//
//  Created by Pinto Junior, William James on 05/04/22.
//

import UIKit

class ModalAddTaskViewController: UIViewController {
    // MARK: - Variables
    var buttonModalFunction: (() -> Void)? = nil
    
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
    
    fileprivate lazy var buttonCancel: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.setTitleColor(UIColor(named: "Disabled"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    fileprivate let labelTitle: UILabel = {
        let label = UILabel()
        label.text = "New task"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var buttonDone: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.setTitleColor(UIColor(named: "Disabled"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        return button
    }()
    
    fileprivate func stackHeader() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(buttonCancel)
        stack.addArrangedSubview(labelTitle)
        stack.addArrangedSubview(buttonDone)
        return stack
    }
    
    fileprivate let textFieldTitle: TextFieldCustom = {
        let textField = TextFieldCustom()
        textField.placeholder = "Title"
        return textField
    }()
    
    fileprivate let textFieldDescription: TextFieldCustom = {
        let textField = TextFieldCustom()
        textField.placeholder = "Description"
        return textField
    }()
    
    fileprivate func stackForm() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(textFieldTitle)
        stack.addArrangedSubview(textFieldDescription)
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
        guard let buttonModalFunction = buttonModalFunction else {
            return
        }
        dismiss(animated: false, completion: nil)
        buttonModalFunction()
    }
    
    // MARK: - Methods
    fileprivate func buildHierarchy() {
        view.addSubview(viewBase)
        viewBase.addSubview(stackBase)
        stackBase.addArrangedSubview(stackHeader())
        stackBase.addArrangedSubview(stackForm())
        stackBase.addArrangedSubview(viewStackAux)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            viewBase.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            viewBase.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            viewBase.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            viewBase.heightAnchor.constraint(equalToConstant: 210),
            
            stackBase.topAnchor.constraint(equalTo: viewBase.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackBase.leadingAnchor.constraint(equalTo: viewBase.leadingAnchor, constant: 16),
            stackBase.trailingAnchor.constraint(equalTo: viewBase.trailingAnchor, constant: -16),
            stackBase.bottomAnchor.constraint(equalTo: viewBase.bottomAnchor),
            
            buttonCancel.widthAnchor.constraint(equalToConstant: 70),
            buttonDone.widthAnchor.constraint(equalToConstant: 70),
        ])
    }

}
