//
//  HomeViewController.swift
//  TaskList
//
//  Created by Pinto Junior, William James on 01/04/22.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {
    // MARK: - Constrants
    fileprivate let resuseIdentifierSextionProgress = "TaskCollectionViewCell"
    fileprivate let resuseIdentifierSectionToDo = "SectionToDoCollectionViewCell"
    fileprivate let disposeBag = DisposeBag()
    
    // MARK: - Variables
    fileprivate var viewModel: HomeViewModel = {
        return HomeViewModel()
    }()
    fileprivate var toDoList: [TaskModel] = []
    fileprivate var progressList: [TaskModel] = []
    
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
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = UIColor(named: "Text")
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
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
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
        
        modalVC.taskSubjectObservable.subscribe(onNext: { task in
            self.viewModel.newTask(task)
        }).disposed(by: disposeBag)
        
        self.present(modalVC, animated: false, completion: nil)
    }

    // MARK: - Setup
    fileprivate func setupVC() {
        view.backgroundColor = UIColor(named: "Backgroud")
        
        viewModel.taskBehavior.subscribe(onNext: { tasks in
            print("Subscribe Home")
            
            var toDoAux: [TaskModel] = []
            var progressAux: [TaskModel] = []
        
            tasks.forEach { task in
                if task.status == .progress {
                    progressAux.append(task)
                    return
                }
                toDoAux.append(task)
            }
            
            self.toDoList = toDoAux
            self.progressList = progressAux
            self.taskCollectionView.reloadData()
        }).disposed(by: disposeBag)
        
        self.labelDate.text = getDateToday()
        
        buildHierarchy()
        buildConstraints()
        setupCollection()
        setupNavbar()
    }
    
    fileprivate func setupCollection() {
        taskCollectionView.dataSource = self
        taskCollectionView.delegate = self
        
        taskCollectionView.register(SectionToDoCollectionViewCell.self, forCellWithReuseIdentifier: resuseIdentifierSectionToDo)
        taskCollectionView.register(TaskCollectionViewCell.self, forCellWithReuseIdentifier: resuseIdentifierSextionProgress)
    }
    
    // MARK: - Methods
    fileprivate func getDateToday() -> String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "dd MMMM"
        return dateFormatter.string(from: now)
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

// MARK: - extension CollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            return
        }
        
        let seeTask = SeeTaskViewController()
        seeTask.viewModel.subTaskBehavior.accept(progressList[indexPath.row])
        seeTask.viewModel.subTaskBehavior.skip(1).subscribe(onNext: { task in
            print("Subscribe updateTask")
            self.viewModel.updateTask(task)
        }).disposed(by: disposeBag)
        self.navigationController?.pushViewController(seeTask, animated: true)
    }
}

// MARK: - extension CollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    // Section
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        return progressList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: resuseIdentifierSectionToDo, for: indexPath) as! SectionToDoCollectionViewCell
            cell.settingCell(task: toDoList)
            
            cell.seeTaskSubjectObservable.subscribe(onNext: { task in
                print("Subscribe ToDo Click")
                let seeTask = SeeTaskViewController()
                
                seeTask.viewModel.subTaskBehavior.accept(task)
                
                seeTask.viewModel.subTaskBehavior.skip(1).subscribe(onNext: { oldTask in
                    print("Subscribe updateTask ToDo")
                    self.viewModel.updateTask(oldTask)
                }).disposed(by: self.disposeBag)
                
                self.navigationController?.pushViewController(seeTask, animated: true)
            }).disposed(by: disposeBag)
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: resuseIdentifierSextionProgress, for: indexPath) as! TaskCollectionViewCell
        cell.settingCell(task: progressList[indexPath.row])
        return cell
    }
}

// MARK: - extension CollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        
        if indexPath.section == 0 {
            return CGSize(width: width, height: 238)
        }
        
        return CGSize(width: width, height: 110)
    }
}

