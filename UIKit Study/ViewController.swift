import UIKit

#Preview {
    ViewController()
}

class ViewController: UIViewController {
    
    let rectangleView1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()
    
    let rectangleView2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(rectangleView1)
        view.addSubview(rectangleView2)
        
        NSLayoutConstraint.activate([
            rectangleView1.widthAnchor.constraint(equalToConstant: 200),
            rectangleView1.heightAnchor.constraint(equalToConstant: 100),
            rectangleView1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rectangleView1.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            
            rectangleView2.widthAnchor.constraint(equalToConstant: 300),
            rectangleView2.heightAnchor.constraint(equalToConstant: 200),
            rectangleView2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rectangleView2.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100)
        ])
    }
}
