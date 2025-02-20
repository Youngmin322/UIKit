import UIKit

#Preview {
    KakaoChatViewController()
}

struct Chat {
    let profileImage: String
    let name: String
    let lastMessage: String
    let time: String
}

class KakaoChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "채팅"
        label.textColor = .black
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false // // AutoLayout을 사용하기 위해 autoresizing mask를 비활성화
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
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let chatList: [Chat] = [
        Chat(profileImage: "person.crop.circle.fill", name: "수진", lastMessage: "오늘 뭐해?", time: "어제")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupViews()
        setupTableView()
    }
    
    func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(searchButton)
        view.addSubview(settingButton)
        view.addSubview(plusButton)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            searchButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            searchButton.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: -15), // 플러스 버튼 왼쪽에 위치
            
            plusButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            plusButton.trailingAnchor.constraint(equalTo: settingButton.leadingAnchor, constant: -15), // 설정 버튼 왼쪽에 위치
            
            settingButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor), // titleLabel과 같은 Y축에 위치
            settingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20), // 화면 오른쪽에 위치
            
            searchButton.widthAnchor.constraint(equalToConstant: 24),
            searchButton.heightAnchor.constraint(equalToConstant: 24),
            
            settingButton.widthAnchor.constraint(equalToConstant: 24),
            settingButton.heightAnchor.constraint(equalToConstant: 24),
            
            plusButton.widthAnchor.constraint(equalToConstant: 24),
            plusButton.heightAnchor.constraint(equalToConstant: 24),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // 현재 뷰 컨트롤러가 테이블 뷰의 동작을 관리하도록 함
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChatCell.self, forCellReuseIdentifier: "ChatCell")
        
        tableView.rowHeight = 60
    }
    
    // 테이블 뷰의 행 개수를 반환하는 메서드로 현재 chatlist 배열의 개수만큼 행을 생성함
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatList.count
    }
    
    // 테이블 뷰에서 각 행에 들어갈 셀을 생성하고 설정하는 메서드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        let chat = chatList[indexPath.row]
        cell.configure(with: chat)
        return cell
    }
}

class ChatCell: UITableViewCell {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(messageLabel)
        addSubview(timeLabel)
        
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 50),
            profileImageView.heightAnchor.constraint(equalToConstant: 50),
            
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 15),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 7),
            
            messageLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            messageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            
            timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            timeLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor)
        ])
    }
    
    // UITableViewCell은 인터페이스 빌더에서 사용할 수도 있기 때문에 기본적으로 init(coder:)가 필요하지만 단순 UI를 구현하는 것이기 때문에 init이 호출될 일이 없어서 강제로 fatalError를 발생시켜서 사용을 막음
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // ChatCell에 데이터를 설정하는 메서드, 채팅 리스트에 데이터를 표시하는 역할
    func configure(with chat: Chat) {
        profileImageView.image = UIImage(systemName: chat.profileImage)
        nameLabel.text = chat.name
        messageLabel.text = chat.lastMessage
        timeLabel.text = chat.time
    }
}
