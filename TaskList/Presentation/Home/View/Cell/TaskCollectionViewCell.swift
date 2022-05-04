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
        stack.spacing = 8
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let stackHeader: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let viewBoxView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let viewBox: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Text")
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let imageViewClone: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Clone")
        
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    fileprivate let labelTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let labelPriority: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "Disabled")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let viewStackLabelAux: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate func stackLabel() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(labelTitle)
        stack.addArrangedSubview(labelPriority)
        stack.addArrangedSubview(viewStackLabelAux)
        return stack
    }
    
    fileprivate let viewStatus: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Text")
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let viewStackStatusAux: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate func stackStatus() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(viewStatus)
        stack.addArrangedSubview(viewStackStatusAux)
        return stack
    }
    
    fileprivate let labelStatus: UILabel = {
        let label = UILabel()
        label.text = "08/20"
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(named: "White")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let progressBar: UIProgressView = {
            let progressView = UIProgressView()
            progressView.trackTintColor = UIColor(named: "Disabled")
            progressView.transform = CGAffineTransform(scaleX: 1, y: 0.8)
            progressView.layer.cornerRadius = 1
            progressView.clipsToBounds = true
            
            progressView.tintColor = UIColor(named: "Text")
            progressView.setProgress(0, animated: true)
            return progressView
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
        self.backgroundColor = UIColor(named: "Card")
        
        buildHierarchy()
        buildConstraints()
    }
    
    // MARK: - Methods
    func settingCell(task: TaskModel) {
        self.labelTitle.text = task.title
        self.labelPriority.text = task.priority == .basic ? "Basic" : task.priority == .important ? "Important" : "Urgent"
        setProgressBar(subTasks: task.subTasks)
        setStatus(subTasks: task.subTasks)
    }
    
    fileprivate func setProgressBar(subTasks: [SubTaskModel]) {
        if subTasks.count == 0 {
            progressBar.setProgress(0, animated: true)
            return
        }
        
        var numberIsActive = 0
        subTasks.forEach { item in
            if item.isComplet  {
                numberIsActive += 1
            }
        }
        
        progressBar.progress = Float(numberIsActive) / Float(subTasks.count)
    }
    
    fileprivate func setStatus(subTasks: [SubTaskModel]) {
        if subTasks.count == 0 {
            self.labelStatus.text = "0/0"
            return
        }
        
        var numberIsActive = 0
        subTasks.forEach { item in
            if item.isComplet  {
                numberIsActive += 1
            }
        }
        
        self.labelStatus.text = "\(numberIsActive)/\(subTasks.count)"
    }
    
    
    fileprivate func buildHierarchy() {
        self.addSubview(stackBase)
        stackBase.addArrangedSubview(stackHeader)
        stackBase.addArrangedSubview(progressBar)
        
        stackHeader.addArrangedSubview(viewBoxView)
        stackHeader.addArrangedSubview(stackLabel())
        stackHeader.addArrangedSubview(stackStatus())
        
        viewBoxView.addSubview(viewBox)
        viewBox.addSubview(imageViewClone)
        viewStatus.addSubview(labelStatus)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            
            viewBoxView.widthAnchor.constraint(equalToConstant: 40),
            
            viewBox.centerXAnchor.constraint(equalTo: viewBoxView.centerXAnchor),
            viewBox.widthAnchor.constraint(equalToConstant: 35),
            viewBox.heightAnchor.constraint(equalToConstant: 35),
            
            imageViewClone.heightAnchor.constraint(equalToConstant: 15),
            imageViewClone.widthAnchor.constraint(equalToConstant: 15),
            imageViewClone.centerXAnchor.constraint(equalTo: viewBox.centerXAnchor),
            imageViewClone.centerYAnchor.constraint(equalTo: viewBox.centerYAnchor),
            
            viewStatus.widthAnchor.constraint(equalToConstant: 60),
            viewStatus.heightAnchor.constraint(equalToConstant: 25),
            
            labelStatus.centerXAnchor.constraint(equalTo: viewStatus.centerXAnchor),
            labelStatus.centerYAnchor.constraint(equalTo: viewStatus.centerYAnchor),
        ])
    }
}
