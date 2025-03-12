//
//  SecondViewController.swift
//  HelloWorld
//
//  Created by 조영민 on 3/12/25.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        self.view.backgroundColor = .yellow
        
        let label = UILabel()
        label.text = "Second View"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24)
        label.frame = CGRect(x: 20, y: 100, width: view.frame.width - 40, height: 40)
        self.view.addSubview(label)
    }
}
