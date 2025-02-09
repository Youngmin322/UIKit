//
//  ViewController.swift
//  UIKit Study
//
//  Created by 조영민 on 2/9/25.
//

import UIKit

#Preview {
    ViewController()
}

class ViewController: UIViewController {
    
    lazy var myNameTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "피피아노"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .black
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        
        view.addSubview(myNameTextLabel)
        myNameTextLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        myNameTextLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        myNameTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myNameTextLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }


}

