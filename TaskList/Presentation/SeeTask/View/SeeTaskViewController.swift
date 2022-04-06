//
//  SeeTaskViewController.swift
//  TaskList
//
//  Created by Pinto Junior, William James on 04/04/22.
//

import UIKit

class SeeTaskViewController: UIViewController {
    // MARK: - Constrants
    fileprivate let subTaskResuseIdentifier = "SubTaskCollectionViewCell"
    
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
    
    fileprivate let viewProcess: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.85, green: 0.88, blue: 0.98, alpha: 1.00)
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let labelProcess: UILabel = {
        let label = UILabel()
        label.text = "On Going"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor(red: 0.32, green: 0.43, blue: 0.90, alpha: 1.00)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
    
    fileprivate func stackProcess() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(labelDate)
        stack.addArrangedSubview(viewProcess)
        return stack
    }
    
    fileprivate func stackTitle() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(labelTitle)
        stack.addArrangedSubview(stackProcess())
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
        modalVC.buttonModalFunction = buttonDonePress
        self.present(modalVC, animated: false, completion: nil)
    }

    
    // MARK: - Setup
    fileprivate func setupVC() {
        view.backgroundColor = UIColor(named: "Backgroud")
        self.title = "Task Detail"
        
        viewModel.delegate = self
        task = viewModel.getTask()
        
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
    fileprivate func buttonDonePress(title: String) {
        viewModel.newSubTask(title)
    }
    
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
        
        viewProcess.addSubview(labelProcess)
        
        view.addSubview(buttonAdd)
        buttonAdd.addSubview(imageViewPlus)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            stackBase.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackBase.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            stackBase.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            viewProcess.heightAnchor.constraint(equalToConstant: 30),
            viewProcess.widthAnchor.constraint(equalToConstant: 80),
            
            labelProcess.centerXAnchor.constraint(equalTo: viewProcess.centerXAnchor),
            labelProcess.centerYAnchor.constraint(equalTo: viewProcess.centerYAnchor),
            
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
        self.navigationItem.backButtonTitle = ""
    }
}

// MARK: - extension SeeTaskViewModelDelegate
extension SeeTaskViewController: SeeTaskViewModelDelegate {
    func reloadCollection() {
        self.task = viewModel.getTask()
        self.subTaskCollectionView.reloadData()
    }    
}

// MARK: - extension SubTaskCollectionViewCellDelegate
extension SeeTaskViewController: SubTaskCollectionViewCellDelegate {
    func updateSubTask(subTask: SubTaskModel, idSubTask: Int) {
        viewModel.updateSubTask(idSubTask: idSubTask, subTask: subTask)
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

