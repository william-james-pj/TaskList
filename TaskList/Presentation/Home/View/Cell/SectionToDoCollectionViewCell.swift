//
//  SectionToDoCollectionViewCell.swift
//  TaskList
//
//  Created by Pinto Junior, William James on 20/04/22.
//

import UIKit
import RxSwift

class SectionToDoCollectionViewCell: UICollectionViewCell {
    // MARK: - Constrants
    fileprivate let resuseIdentifierToDo = "ToDoCollectionViewCell"
    fileprivate let seeTaskSubject = PublishSubject<TaskModel>()
    
    // MARK: - Variables
    var seeTaskSubjectObservable: Observable<TaskModel> {
        return seeTaskSubject.asObserver()
    }
    fileprivate var toDoList: [TaskModel] = []
    
    // MARK: - Components
    fileprivate let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 32
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let labelTitle: UILabel = {
        let label = UILabel()
        label.text = "To Do"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = UIColor(red: 0.16, green: 0.16, blue: 0.18, alpha: 1.00)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let collectionViewToDo: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    fileprivate func stackCollection() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(labelTitle)
        stack.addArrangedSubview(collectionViewToDo)
        return stack
    }
    
    fileprivate let labelProgress: UILabel = {
        let label = UILabel()
        label.text = "In Progress"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = UIColor(red: 0.16, green: 0.16, blue: 0.18, alpha: 1.00)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        buildHierarchy()
        buildConstraints()
        setupCollection()
    }
    
    fileprivate func setupCollection() {
        collectionViewToDo.dataSource = self
        collectionViewToDo.delegate = self
        
        collectionViewToDo.register(ToDoCollectionViewCell.self, forCellWithReuseIdentifier: resuseIdentifierToDo)
    }
    
    // MARK: - Methods
    func settingCell(task: [TaskModel]) {
        self.toDoList = task
        self.collectionViewToDo.reloadData()
    }
    
    fileprivate func buildHierarchy() {
        self.addSubview(stackBase)
        stackBase.addArrangedSubview(stackCollection())
        stackBase.addArrangedSubview(labelProgress)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: self.topAnchor),
            stackBase.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackBase.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackBase.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            
            collectionViewToDo.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
}

// MARK: - extension CollectionViewDelegate
extension SectionToDoCollectionViewCell: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Delegate click")
        seeTaskSubject.onNext(toDoList[indexPath.row])
    }
}

// MARK: - extension CollectionViewDataSource
extension SectionToDoCollectionViewCell: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: resuseIdentifierToDo, for: indexPath) as! ToDoCollectionViewCell
        cell.settingCell(task: toDoList[indexPath.row])
        return cell
    }
}

// MARK: - extension CollectionViewDelegateFlowLayout
extension SectionToDoCollectionViewCell: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 2) - 32
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
}
