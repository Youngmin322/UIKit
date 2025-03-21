//
//  TodoCell.swift
//  ToDoList_UIKit
//
//  Created by 조영민 on 3/21/25.
//

import UIKit

class TodoCell: UITableViewCell {

    private let titleLabel = UILabel()
    private let dueLabel = UILabel()
    private let statusView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {

        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.numberOfLines = 1
        
        dueLabel.font = UIFont.systemFont(ofSize: 14)
        dueLabel.textColor = .darkGray
        
        // 상태 표시기 (완료 여부를 보여줄 원형 뷰)
        statusView.layer.cornerRadius = 6
        statusView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusView.widthAnchor.constraint(equalToConstant: 12),
            statusView.heightAnchor.constraint(equalToConstant: 12)
        ])
        
        let labelsStack = UIStackView(arrangedSubviews: [titleLabel, dueLabel])
        labelsStack.axis = .vertical
        labelsStack.spacing = 4
        
        let mainStack = UIStackView(arrangedSubviews: [statusView, labelsStack])
        mainStack.axis = .horizontal
        mainStack.spacing = 12
        mainStack.alignment = .center
        
        contentView.addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    // 셀 데이터 구성
    func configure(with todo: Todo) {
        titleLabel.text = todo.title
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        if let dueDate = todo.dueDate {
            dueLabel.text = "마감일: \(dateFormatter.string(from: dueDate))"
        } else {
            dueLabel.text = "마감일 없음"
        }
        
        statusView.backgroundColor = todo.isCompleted ? .systemGreen : .systemRed
        
        // 완료된 할 일은 취소선 추가
        if todo.isCompleted {
            let attributedString = NSAttributedString(
                string: todo.title ?? "",
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
            titleLabel.attributedText = attributedString
        } else {
            titleLabel.attributedText = nil
        }
    }
}

