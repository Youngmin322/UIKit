import UIKit

struct Chat {
    let profileImage: String
    let name: String
    let lastMessage: String
    let time: String
}

// 채팅 리스트 셀
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with chat: Chat) {
        profileImageView.image = UIImage(systemName: chat.profileImage)
        nameLabel.text = chat.name
        messageLabel.text = chat.lastMessage
        timeLabel.text = chat.time
    }
}

// 채팅 목록 화면
class KakaoChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        return button
    }()
    
    let settingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "gearshape"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let chatList: [Chat] = [
        Chat(profileImage: "person.crop.circle.fill", name: "튜나 센세", lastMessage: "원양어선으로 오도록", time: "어제"),
        Chat(profileImage: "person.crop.circle.fill", name: "팀쿡", lastMessage: "아이폰 사고 싶다..", time: "그저께")
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
            searchButton.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: -15),
            
            plusButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            plusButton.trailingAnchor.constraint(equalTo: settingButton.leadingAnchor, constant: -15),
            
            settingButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            settingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // UITableView를 설정하고 데이터를 표시하는 메서드
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChatCell.self, forCellReuseIdentifier: "ChatCell")
        tableView.rowHeight = 60 // 각 셀의 높이를 60 포인트로 설정
    }
    
    // ChatList의 배열의 개수만큼 행을 표시
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatList.count
    }
    
    // 각 행에 표시될 셀을 구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        cell.configure(with: chatList[indexPath.row])
        return cell
    }
}

// 카카오톡 스타일 탭 바 컨트롤러
class KakaoTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let friendTab = KakaoChatViewController()
        friendTab.tabBarItem = UITabBarItem(title: "친구", image: UIImage(systemName: "person.fill"), tag: 0)
        
        let chatTab = KakaoChatViewController()
        chatTab.tabBarItem = UITabBarItem(title: "채팅", image: UIImage(systemName: "message.fill"), tag: 1)
        
        let openChatTab = KakaoChatViewController()
        openChatTab.tabBarItem = UITabBarItem(title: "오픈 채팅", image: UIImage(systemName: "plus.message.fill"), tag: 2)
        
        let shopTab = KakaoChatViewController()
        shopTab.tabBarItem = UITabBarItem(title: "쇼핑", image: UIImage(systemName: "bag"), tag: 3)
        
        let settingTab = KakaoChatViewController()
        settingTab.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "ellipsis"), tag: 4)
        
        let moreTab = KakaoChatViewController()
        moreTab.tabBarItem = UITabBarItem(title: "야호", image: UIImage(systemName: "ellipsis"), tag: 5)
        
        viewControllers = [friendTab, chatTab, openChatTab, shopTab, settingTab]
        tabBar.tintColor = .black
    }
}

// 프리뷰 지원
#Preview {
    KakaoTabBarController()
}
