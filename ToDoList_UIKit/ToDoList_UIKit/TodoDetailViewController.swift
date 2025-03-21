//
//  TodoDetailViewController.swift
//  ToDoList_UIKit
//
//  Created by 조영민 on 3/21/25.
//

import UIKit

class TodoDetailViewController: UIViewController {
    
    // 수정할 할 일 객체 (nil이면 새로운 할 일 생성)
    private let todo: Todo?
    
    // UI 구성요소
    private let titleTextField = UITextField()
    private let contentTextView = UITextView()
    private let dueDatePicker = UIDatePicker()
    private let saveButton = UIButton(type: .system)
    
    // 초기화
    init(todo: Todo?) {
        self.todo = todo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        
        // 할 일 정보가 있으면 화면에 표시
        if let todo = todo {
            titleTextField.text = todo.title
            contentTextView.text = todo.content
            dueDatePicker.date = todo.dueDate ?? Date()
        }
    }
    
    // UI 설정
    private func setupUI() {
        view.backgroundColor = .white
        
        // 타이틀 텍스트필드
        titleTextField.placeholder = "제목"
        titleTextField.borderStyle = .roundedRect
        titleTextField.font = UIFont.systemFont(ofSize: 16)
        
        // 내용 텍스트뷰
        contentTextView.font = UIFont.systemFont(ofSize: 16)
        contentTextView.layer.borderColor = UIColor.lightGray.cgColor
        contentTextView.layer.borderWidth = 1
        contentTextView.layer.cornerRadius = 5
        
        // 날짜 선택기
        dueDatePicker.datePickerMode = .dateAndTime
        dueDatePicker.preferredDatePickerStyle = .compact
        
        // 저장 버튼
        saveButton.setTitle("저장", for: .normal)
        saveButton.backgroundColor = .systemBlue
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 10
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        // 레이블
        let dueDateLabel = UILabel()
        dueDateLabel.text = "마감일"
        dueDateLabel.font = UIFont.systemFont(ofSize: 16)
        
        let contentLabel = UILabel()
        contentLabel.text = "내용"
        contentLabel.font = UIFont.systemFont(ofSize: 16)
        
        // 스택뷰에 추가
        let stackView = UIStackView(arrangedSubviews: [
            titleTextField,
            contentLabel,
            contentTextView,
            dueDateLabel,
            dueDatePicker,
            saveButton
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.setCustomSpacing(8, after: contentLabel)
        stackView.setCustomSpacing(8, after: dueDateLabel)
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            contentTextView.heightAnchor.constraint(equalToConstant: 150),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // 네비게이션 바 설정
    private func setupNavigationBar() {
        title = todo == nil ? "새 할 일" : "할 일 수정"
        
        let cancelButton = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelButtonTapped)
        )
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    // 취소 버튼 액션
    @objc private func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    // 저장 버튼 액션
    @objc private func saveButtonTapped() {
        guard let title = titleTextField.text, !title.isEmpty else {
            showAlert(message: "제목을 입력해주세요.")
            return
        }
        
        if let todo = todo {
            // 기존 할 일 업데이트
            todo.title = title
            todo.content = contentTextView.text
            todo.dueDate = dueDatePicker.date
            
            CoreDataManager.shared.updateTodo(todo)
        } else {
            // 새 할 일 생성
            _ = CoreDataManager.shared.createTodo(
                title: title,
                content: contentTextView.text,
                dueDate: dueDatePicker.date
            )
        }
        
        dismiss(animated: true)
    }
    
    // 알림창 표시
    private func showAlert(message: String) {
        let alert = UIAlertController(
            title: "알림",
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
