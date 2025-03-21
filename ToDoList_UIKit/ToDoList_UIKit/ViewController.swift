//
//  ViewController.swift
//  ToDoList_UIKit
//
//  Created by 조영민 on 3/21/25.
//

import UIKit

class TodoListViewController: UIViewController {
    
    private let tableView = UITableView()
    private var todos: [Todo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchTodos() // 화면이 나타날 때마다 데이터 새로고침
    }
    
    // UI 설정
    private func setupUI() {
        view.backgroundColor = .white
        
        // 테이블뷰 설정
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TodoCell.self, forCellReuseIdentifier: "TodoCell")
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // 네비게이션 바 설정
    private func setupNavigationBar() {
        title = "할 일 목록"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
        navigationItem.rightBarButtonItem = addButton
    }
    
    // CoreData에서 할 일 목록 가져오기
    private func fetchTodos() {
        todos = CoreDataManager.shared.fetchTodos()
        tableView.reloadData()
    }
    
    // 할 일 추가 버튼 액션
    @objc private func addButtonTapped() {
        let detailVC = TodoDetailViewController(todo: nil)
        let navController = UINavigationController(rootViewController: detailVC)
        present(navController, animated: true)
    }
}

// MARK: - TableView 델리게이트 및 데이터소스
extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoCell
        let todo = todos[indexPath.row]
        cell.configure(with: todo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 할 일 선택 시 상세 화면으로 이동
        let todo = todos[indexPath.row]
        let detailVC = TodoDetailViewController(todo: todo)
        let navController = UINavigationController(rootViewController: detailVC)
        present(navController, animated: true)
    }
    
    // 스와이프 액션 구현
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // 삭제 액션
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { [weak self] _, _, completion in
            guard let self = self else { return }
            
            let todoToDelete = self.todos[indexPath.row]
            CoreDataManager.shared.deleteTodo(todoToDelete)
            
            self.todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            completion(true)
        }
        
        // 완료 토글 액션
        let todo = todos[indexPath.row]
        let toggleTitle = todo.isCompleted ? "미완료" : "완료"
        let toggleAction = UIContextualAction(style: .normal, title: toggleTitle) { [weak self] _, _, completion in
            guard let self = self else { return }
            
            todo.isCompleted.toggle()
            CoreDataManager.shared.updateTodo(todo)
            tableView.reloadRows(at: [indexPath], with: .automatic)
            
            completion(true)
        }
        toggleAction.backgroundColor = todo.isCompleted ? .orange : .green
        
        return UISwipeActionsConfiguration(actions: [deleteAction, toggleAction])
    }
}


#Preview {
    TodoListViewController()
}
