//
//  SeeTaskViewController.swift
//  TaskList
//
//  Created by Pinto Junior, William James on 04/04/22.
//

import UIKit
import RxSwift

class SeeTaskViewController: UIViewController {
    // MARK: - Constrants
    fileprivate let subTaskResuseIdentifier = "SubTaskCollectionViewCell"
    fileprivate let disposeBag = DisposeBag()
    
    // MARK: - Variables
    var viewModel: SeeTaskViewModel = {
        return SeeTaskViewModel()
    }()
    fileprivate var task: TaskModel = TaskModel()
    
    // MARK: - Components
    fileprivate let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 32
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let labelDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(named: "Disabled")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let viewStackAux: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var buttonProcess: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.85, green: 0.88, blue: 0.98, alpha: 1.00)
        
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        button.setTitleColor(UIColor(red: 0.32, green: 0.43, blue: 0.90, alpha: 1.00), for: .normal)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(processButtonTapped), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var buttonPriority: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.85, green: 0.88, blue: 0.98, alpha: 1.00)
        
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        button.setTitleColor(UIColor(red: 0.32, green: 0.43, blue: 0.90, alpha: 1.00), for: .normal)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(priorityButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    fileprivate func stackButtons() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(buttonPriority)
        stack.addArrangedSubview(buttonProcess)
        return stack
    }
    
    fileprivate let labelTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let labelDescription: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(named: "Disabled")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let labelDescriptionText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 3
        
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate func stackDescription() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(labelDescription)
        stack.addArrangedSubview(labelDescriptionText)
        return stack
    }
    
    fileprivate let labelSubTask: UILabel = {
        let label = UILabel()
        label.text = "Sub Task"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(named: "Disabled")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let subTaskCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    fileprivate func stackSubTask() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(labelSubTask)
        stack.addArrangedSubview(subTaskCollectionView)
        return stack
    }
    
    fileprivate func stackDate() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(labelDate)
        stack.addArrangedSubview(stackButtons())
        return stack
    }
    
    fileprivate func stackTitle() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(labelTitle)
        stack.addArrangedSubview(stackDate())
        return stack
    }
    
    fileprivate lazy var buttonAdd: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "Text")
        
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    fileprivate let imageViewPlus: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Plus")
        
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    // MARK: - Action
    @IBAction func addButtonTapped() -> Void {
        let modalVC = ModalAddSubTaskViewController()
        modalVC.modalPresentationStyle = .overCurrentContext
        
        modalVC.subTaskSubjectObservable.subscribe(onNext: { subTask in
            self.viewModel.newSubTask(subTask)
        }).disposed(by: disposeBag)
        
        self.present(modalVC, animated: false, completion: nil)
    }
    
    @IBAction func processButtonTapped() {
        viewModel.updateStatusTask()
    }
    
    @IBAction func priorityButtonTapped() {
        viewModel.updatePriorityTask()
    }
    
    // MARK: - Setup
    fileprivate func setupVC() {
        view.backgroundColor = UIColor(named: "Backgroud")
//        self.title = "Task Detail"
        
        viewModel.subTaskBehavior.subscribe(onNext: { task in
            print("Subscribe SeeTask")
            
            self.buttonProcess.setTitle(task.status == .toDo ? "To do" : task.status == .progress ? "In process" : "Complete", for: .normal)
            
            self.buttonPriority.setTitle(task.priority == .basic ? "Basic" : task.priority == .important ? "Important" : "Urgent", for: .normal)
            
            self.task = task
            self.subTaskCollectionView.reloadData()
        }).disposed(by: disposeBag)

        buildHierarchy()
        buildConstraints()
        setupCollection()
        settingData()
        setupNavbar()
    }
    
    fileprivate func setupCollection() {
        subTaskCollectionView.dataSource = self
        subTaskCollectionView.delegate = self
        
        subTaskCollectionView.register(SubTaskCollectionViewCell.self, forCellWithReuseIdentifier: subTaskResuseIdentifier)
    }

    // MARK: - Methods    
    fileprivate func settingData() {
        self.labelTitle.text = task.title
        self.labelDate.text = task.dateString
        self.labelDescriptionText.text = task.description
    }
    
    fileprivate func buildHierarchy() {
        view.addSubview(stackBase)
        stackBase.addArrangedSubview(stackTitle())
        stackBase.addArrangedSubview(stackDescription())
        stackBase.addArrangedSubview(stackSubTask())
        stackBase.addArrangedSubview(viewStackAux)
        
        view.addSubview(buttonAdd)
        buttonAdd.addSubview(imageViewPlus)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            stackBase.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackBase.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            stackBase.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            buttonProcess.heightAnchor.constraint(equalToConstant: 30),
            buttonProcess.widthAnchor.constraint(equalToConstant: 80),
            
            buttonPriority.heightAnchor.constraint(equalToConstant: 30),
            buttonPriority.widthAnchor.constraint(equalToConstant: 80),
            
            buttonAdd.heightAnchor.constraint(equalToConstant: 50),
            buttonAdd.widthAnchor.constraint(equalToConstant: 50),
            buttonAdd.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            buttonAdd.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            imageViewPlus.heightAnchor.constraint(equalToConstant: 25),
            imageViewPlus.widthAnchor.constraint(equalToConstant: 25),
            imageViewPlus.centerXAnchor.constraint(equalTo: buttonAdd.centerXAnchor),
            imageViewPlus.centerYAnchor.constraint(equalTo: buttonAdd.centerYAnchor),
        ])
    }
    
    fileprivate func setupNavbar() {
        let buttonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: nil)
        buttonItem.menu = UIMenu(title: "", children: [deleteAction])
        self.navigationItem.rightBarButtonItem = buttonItem
        self.navigationItem.rightBarButtonItem!.tintColor = UIColor(named: "Text")
        
    }
    
    fileprivate lazy var deleteAction = UIAction(title: "Delete task") { _ in
        self.navigationController?.popViewController(animated: true)
        self.viewModel.deleteTask()
    }
}

// MARK: - extension SubTaskCollectionViewCellDelegate
extension SeeTaskViewController: SubTaskCollectionViewCellDelegate {
    func updateSubTask(subTask: SubTaskModel, indexSubTask: Int) {
        viewModel.updateSubTask(indexSubTask: indexSubTask, subTask: subTask)
    }
}

// MARK: - extension CollectionViewDelegate
extension SeeTaskViewController: UICollectionViewDelegate {
}

// MARK: - extension CollectionViewDataSource
extension SeeTaskViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return task.subTasks.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: subTaskResuseIdentifier, for: indexPath) as! SubTaskCollectionViewCell
        cell.settingCell(subTask: task.subTasks[indexPath.row], id: indexPath.row)
        cell.delegate = self
        return cell
    }
}

// MARK: - extension CollectionViewDelegateFlowLayout
extension SeeTaskViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: 70)
    }
}

