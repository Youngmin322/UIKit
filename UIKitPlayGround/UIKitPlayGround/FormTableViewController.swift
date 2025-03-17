//
//  FormTableViewController.swift
//  UIKitPlayGround
//
//  Created by 조영민 on 3/16/25.
//

import UIKit

class FormTableViewController: UITableViewController {
    var flag = false
    let toggle = UISwitch()
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        toggle.addTarget(self, action: #selector(toggleChanged), for: .valueChanged)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemBlue
        config.title = "Button"
        button.isEnabled = flag
        button.configuration = config
        button.sizeToFit()
        
        tableView.headerView(forSection: 0)?.backgroundColor = .systemBlue
        
    }
    
    @objc func toggleChanged(_ sender: UISwitch) {
        flag = sender.isOn
        button.isEnabled = flag
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
      print("Button tapped")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      return "Section Header"
    }

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
      return "Section Footer"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")

            if indexPath.row == 0 {
              toggle.isOn = flag
              cell.accessoryView = toggle
            } else {
              cell.accessoryView = button
            }

        
        if indexPath.row == 0 {
            cell.textLabel?.text = "Toggle Switch"
            cell.accessoryView = toggle
        } else {
            cell.textLabel?.text = "Button"
            cell.accessoryView = button
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}

#Preview {
    FormTableViewController(style: .insetGrouped)
}
