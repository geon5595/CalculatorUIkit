import UIKit
import SnapKit

class ViewController: UIViewController {
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupResultLabel()
        setupButtons()
    }
    
    private func setupResultLabel() {
        view.backgroundColor = .black
        label.text = "0"
        label.backgroundColor = .black
        label.font = .boldSystemFont(ofSize: 60)
        label.textAlignment = .right
        label.textColor = .white
        view.addSubview(label)
        
        // 레이블의 제약 조건 설정
        label.snp.makeConstraints {
            $0.width.equalTo(350)
            $0.height.equalTo(100)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(200)
        }
    }
    
    private func setupButtons() {
        // 버튼 제목 배열
        let buttonTitles = [
            ["7", "8", "9", "+"],
            ["4", "5", "6", "-"],
            ["1", "2", "3", "*"],
            ["AC", "0", "=", "/"]
        ]
        
        var horizontalStackViews = [UIStackView]()
        
        for titles in buttonTitles {
            var buttons = [UIButton]()
            for title in titles {
                if ["0","1","2","3","4","5","6","7","8","9"].contains(title) {
                    let button = makeStyledButton(title: title)
                    buttons.append(button)
                } else {
                    let button = makeStyledButton(title: title)
                    button.backgroundColor = .orange
                    buttons.append(button)
                }
            }
            let hStack = makeHorizontalStackView(buttons)
            horizontalStackViews.append(hStack)
        }
        
        let vStack = makeVerticalStackView(horizontalStackViews)
        view.addSubview(vStack)
        
        // 수직 스택 뷰의 제약 조건 설정
        vStack.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(350)
        }
    }
    
    func makeHorizontalStackView(_ views: [UIView]) -> UIStackView {
        let horizontalStackView = UIStackView(arrangedSubviews: views)
        horizontalStackView.axis = .horizontal
        horizontalStackView.backgroundColor = .black
        horizontalStackView.spacing = 10
        horizontalStackView.distribution = .fillEqually
        return horizontalStackView
    }
    
    func makeVerticalStackView(_ views: [UIView]) -> UIStackView {
        let verticalStackView = UIStackView(arrangedSubviews: views)
        verticalStackView.axis = .vertical
        verticalStackView.backgroundColor = .black
        verticalStackView.spacing = 10
        verticalStackView.distribution = .fillEqually
        return verticalStackView
    }
    
    func makeStyledButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 30)
        button.backgroundColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
        button.layer.cornerRadius = 40
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        return button
    }
    func calculate(expression: String) -> Int? {
        let expression = NSExpression(format: expression)
        if let result = expression.expressionValue(with: nil, context: nil) as? Int{
            return result
        } else {
            return nil
        }
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        if label.text == "0" {
            label.text = ""
        }
        if ["0","1","2","3","4","5","6","7","8","9","+","-","*","/"].contains(sender.currentTitle) {
            label.text! += sender.currentTitle!
        } else if sender.currentTitle == "=" {
            if let result = calculate(expression: label.text!) {
                label.text = String(result)
            }
        } else {
            label.text = "0"
        }
        
    }
}
