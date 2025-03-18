//
//  ViewController.swift
//  MenuDemo
//
//  Created by 조영민 on 3/18/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        
        // 디폴트 버튼 설정
        var config = UIButton.Configuration.plain()
        config.title = "Apple"
        config.baseBackgroundColor = .systemBlue
        
        // 밑줄 스타일
        let attributedTitle = AttributedString("String")
        var container = AttributeContainer()
        container.underlineStyle = .single
        container.underlineColor = .systemBlue
        container.font = .systemFont(ofSize: 20)
        
        let underlinedTitle = attributedTitle.settingAttributes(container)
        config.attributedTitle = underlinedTitle
        
        // 버튼 생성
        let button = UIButton(configuration: config)
        button.addAction(UIAction { [weak self] _ in
            print("버튼 클릭")
            self?.openLink()
        }, for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        
        // 제약 조건 설정
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func openLink() {
        if let url = URL(string: "https://www.apple.com"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

}



