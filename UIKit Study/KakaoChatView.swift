import UIKit

#Preview {
    KakaoChatView()
}

class KakaoChatView: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "채팅"
        label.textColor = .black
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    let settingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "gearshape"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal) // 플러스 아이콘
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(searchButton)
        view.addSubview(settingButton)
        view.addSubview(plusButton) // 플러스 버튼 추가
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            searchButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            searchButton.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: -10), // 플러스 버튼 왼쪽에 위치
            
            plusButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            plusButton.trailingAnchor.constraint(equalTo: settingButton.leadingAnchor, constant: -10), // 설정 버튼 왼쪽에 위치
            
            settingButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor), // titleLabel과 같은 Y축에 위치
            settingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20), // 화면 오른쪽에 위치
            
            searchButton.widthAnchor.constraint(equalToConstant: 24),
            searchButton.heightAnchor.constraint(equalToConstant: 24),
            
            settingButton.widthAnchor.constraint(equalToConstant: 24),
            settingButton.heightAnchor.constraint(equalToConstant: 24),
            
            plusButton.widthAnchor.constraint(equalToConstant: 24),
            plusButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}
