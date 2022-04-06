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
    
    fileprivate let labelToday: UILabel = {
        let label = UILabel()
        label.text = "Today,"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(named: "Disabled")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let labelDate: UILabel = {
        let label = UILabel()
        label.text = "27 March"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = UIColor(named: "Text")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    fileprivate func stackHeader() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(labelToday)
        stack.addArrangedSubview(labelDate)
        return stack
    }
    
    fileprivate func stackCollection() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(labelTitle)
        stack.addArrangedSubview(taskCollectionView)
        return stack
    }
    
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
        setupNavbar()
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
        stackBase.addArrangedSubview(stackHeader())
        stackBase.addArrangedSubview(stackCollection())
        view.addSubview(buttonAdd)
        
        buttonAdd.addSubview(imageViewPlus)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
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
    
    fileprivate func setupNavbar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem!.tintColor = UIColor(named: "Text")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "Text")
           
    }

}

// MARK: - extension HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    func reloadCollection() {
        self.taskList = viewModel.getTask()
        self.taskCollectionView.reloadData()
    }
}

// MARK: - extension SeeTaskViewModelDelegateSubTask
extension HomeViewController: SeeTaskViewModelDelegateSubTask {
    func updateSubTask(idTask: Int, subTasks: [SubTaskModel]) {
        viewModel.updateSubTask(idTask: idTask, subTasks: subTasks)
    }
}

// MARK: - extension CollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let seeTask = SeeTaskViewController()
        seeTask.viewModel.setTask(task: taskList[indexPath.row], idTask: indexPath.row)
        seeTask.viewModel.delegateSubTask = self
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

