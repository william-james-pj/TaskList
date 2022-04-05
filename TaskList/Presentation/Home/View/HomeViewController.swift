//
//  HomeViewController.swift
//  TaskList
//
//  Created by Pinto Junior, William James on 01/04/22.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - Constrants
    fileprivate let taskResuseIdentifier = "TaskCollectionViewCell"
    
    // MARK: - Variables
    fileprivate var viewModel: HomeViewModel = {
        return HomeViewModel()
    }()
    fileprivate var taskList: [TaskModel] = []
    
    // MARK: - Components
    fileprivate let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
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
        label.text = "My task"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = UIColor(red: 0.16, green: 0.16, blue: 0.18, alpha: 1.00)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let taskCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
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
        let modalVC = ModalAddTaskViewController()
        modalVC.modalPresentationStyle = .overCurrentContext
        modalVC.buttonModalFunction = buttonDonePress
        self.present(modalVC, animated: false, completion: nil)
    }

    // MARK: - Setup
    fileprivate func setupVC() {
        view.backgroundColor = UIColor(named: "Backgroud")
        
        viewModel.delegate = self
        taskList = viewModel.getTask()
        
        buildHierarchy()
        buildConstraints()
        setupCollection()
    }
    
    fileprivate func setupCollection() {
        taskCollectionView.dataSource = self
        taskCollectionView.delegate = self
        
        taskCollectionView.register(TaskCollectionViewCell.self, forCellWithReuseIdentifier: taskResuseIdentifier)
    }
    
    // MARK: - Methods
    fileprivate func buttonDonePress(title: String, description: String) {
        viewModel.newTask(title, description)
    }
    
    fileprivate func buildHierarchy() {
        view.addSubview(stackBase)
        stackBase.addArrangedSubview(labelTitle)
        stackBase.addArrangedSubview(taskCollectionView)
        view.addSubview(buttonAdd)
        
        buttonAdd.addSubview(imageViewPlus)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackBase.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackBase.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            stackBase.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
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

}

// MARK: - extension HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    func reloadCollection() {
        self.taskList = viewModel.getTask()
        self.taskCollectionView.reloadData()
    }
}

// MARK: - extension CollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let seeTask = SeeTaskViewController()
        seeTask.viewModel.setTask(task: taskList[indexPath.row])
        self.navigationController?.pushViewController(seeTask, animated: true)
    }
}

// MARK: - extension CollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return taskList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: taskResuseIdentifier, for: indexPath) as! TaskCollectionViewCell
        cell.settingCell(task: taskList[indexPath.row])
        return cell
    }
}

// MARK: - extension CollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: 110)
    }
}

