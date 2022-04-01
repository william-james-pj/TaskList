//
//  TaskCollectionViewCell.swift
//  TaskList
//
//  Created by Pinto Junior, William James on 01/04/22.
//

import UIKit

class TaskCollectionViewCell: UICollectionViewCell {
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
        label.text = "College Task"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let labelDate: UILabel = {
        let label = UILabel()
        label.text = "Monday, 8 November"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "Disabled")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate func stackLabel() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(labelTitle)
        stack.addArrangedSubview(labelDate)
        return stack
    }
    
    fileprivate let progressBar: UIProgressView = {
        let progressView = UIProgressView()
        progressView.trackTintColor = UIColor(named: "Disabled")
        progressView.transform = CGAffineTransform(scaleX: 1, y: 0.3)
        progressView.layer.cornerRadius = 1
        progressView.clipsToBounds = true
        
        progressView.tintColor = UIColor(named: "Text")
        progressView.setProgress(0.4, animated: true)
        return progressView
    }()
    
    fileprivate let labelProgress: UILabel = {
        let label = UILabel()
        label.text = "40%"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(named: "Disabled")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate func stackProgress() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(progressBar)
        stack.addArrangedSubview(labelProgress)
        return stack
    }

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
        self.backgroundColor = .white
        
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Methods
    fileprivate func buildHierarchy() {
        self.addSubview(stackBase)
        stackBase.addArrangedSubview(stackLabel())
        stackBase.addArrangedSubview(stackProgress())
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
        ])
    }
}
