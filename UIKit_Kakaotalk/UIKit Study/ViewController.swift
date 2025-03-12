import UIKit

#Preview {
    ViewController()
}

class ViewController: UIViewController {
    
    let label1: UILabel = {
        let label = UILabel()
        label.text = "UIKit AutoLayout 공부"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black
        return label
    }()
    
    let rectangleViewBlue: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()
    
    let rectangleViewRed: UIView = {
        let view = UIView() // rectangleView1에 있는 view와 충돌이 나지 않는 이유는 지역 변수이기 때문에 해당 클로저 안에서만 사용되기 때문, 각각의 view가 이름은 같아도 메모리 주소가 다름!
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    let rectangleViewGreen: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label1)
        view.addSubview(rectangleViewBlue)
        view.addSubview(rectangleViewRed)
        view.addSubview(rectangleViewGreen)
        
        NSLayoutConstraint.activate([
            rectangleViewBlue.widthAnchor.constraint(equalToConstant: 200),
            rectangleViewBlue.heightAnchor.constraint(equalToConstant: 100),
            rectangleViewBlue.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rectangleViewBlue.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            
            rectangleViewRed.widthAnchor.constraint(equalToConstant: 300),
            rectangleViewRed.heightAnchor.constraint(equalToConstant: 200),
            rectangleViewRed.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rectangleViewRed.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
            
            rectangleViewGreen.widthAnchor.constraint(equalToConstant: 80),
            rectangleViewGreen.heightAnchor.constraint(equalToConstant: 70),
            rectangleViewGreen.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200),
            
            label1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            label1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20), // (언어 읽는 순서가 왼쪽에서 오른쪽인 나라에서는 왼쪽 끝에서부터 시작, 반대인 나라는 오른쪽에서 시작)
            label1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
