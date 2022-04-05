//
//  SubTaskCollectionViewCell.swift
//  TaskList
//
//  Created by Pinto Junior, William James on 04/04/22.
//

import UIKit

class SubTaskCollectionViewCell: UICollectionViewCell {
    // MARK: - Variables
    var subTask: SubTaskModel = SubTaskModel()
    var subTaskId: Int = -1
    
    // MARK: - Components
    fileprivate let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let viewCheck: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var buttonCheck: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(named: "Disabled")?.cgColor
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        
        let icon = UIImage(named: "Check")
        let tintedIcon = icon?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedIcon, for: .normal)
        button.tintColor = .clear
        return button
    }()
    
    fileprivate let labelTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let viewImage: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let imageViewArrow: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ArrowDown")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupVC()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    fileprivate func setupVC() {
        self.layer.cornerRadius = 8
        self.backgroundColor = UIColor(named: "White")
        
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Action
    @IBAction func checkButtonTapped() -> Void {
        self.subTask.isComplet = !self.subTask.isComplet
        setChecked()
    }
    
    // MARK: - Methods
    func settingCell(subTask: SubTaskModel, id: Int) {
        self.subTask = subTask
        self.subTaskId = id
        
        self.labelTitle.text = subTask.title
        setChecked()
    }
    
    fileprivate func setChecked() {
        self.subTask.isComplet ? uncheckedButton() : checkedButton()
    }
    
    fileprivate func checkedButton() {
        buttonCheck.layer.borderColor = UIColor(named: "Success")?.cgColor
        buttonCheck.backgroundColor = UIColor(named: "Success")
        buttonCheck.tintColor = UIColor(named: "White")
    }
    
    fileprivate func uncheckedButton() {
        buttonCheck.layer.borderColor = UIColor(named: "Disabled")?.cgColor
        buttonCheck.backgroundColor = .clear
        buttonCheck.tintColor = .clear
    }
    
    fileprivate func buildHierarchy() {
        self.addSubview(stackBase)
        stackBase.addArrangedSubview(viewCheck)
        viewCheck.addSubview(buttonCheck)
        
        stackBase.addArrangedSubview(labelTitle)
        
        stackBase.addArrangedSubview(viewImage)
        viewImage.addSubview(imageViewArrow)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: self.topAnchor),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            viewCheck.widthAnchor.constraint(equalToConstant: 40),
            buttonCheck.heightAnchor.constraint(equalToConstant: 30),
            buttonCheck.widthAnchor.constraint(equalToConstant: 30),
            buttonCheck.centerXAnchor.constraint(equalTo: viewCheck.centerXAnchor),
            buttonCheck.centerYAnchor.constraint(equalTo: viewCheck.centerYAnchor),
            
            viewImage.widthAnchor.constraint(equalToConstant: 30),
            imageViewArrow.heightAnchor.constraint(equalToConstant: 10),
            imageViewArrow.widthAnchor.constraint(equalToConstant: 17),
            imageViewArrow.centerXAnchor.constraint(equalTo: viewImage.centerXAnchor),
            imageViewArrow.centerYAnchor.constraint(equalTo: viewImage.centerYAnchor),
            
        ])
    }
}
