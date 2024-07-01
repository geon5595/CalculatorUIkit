//
//  ViewController.swift
//  CalculatorStoryboard
//
//  Created by pc on 6/27/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var buttonAc: UIButton!
    @IBOutlet weak var buttonEqual: UIButton!
    @IBOutlet weak var buttonPlus: UIButton!
    @IBOutlet weak var buttonMinus: UIButton!
    @IBOutlet weak var buttonMultiply: UIButton!
    @IBOutlet weak var buttonDivide: UIButton!
    
    var resultNumber = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func calculate(expression: String) -> Int? {
        let expression = NSExpression(format: expression)
        if let result = expression.expressionValue(with: nil, context: nil) as? Int{
            return result
        } else {
            return nil
        }
    }
    
    @IBAction func ButtonTapped(_ sender: UIButton) {
        if result.text == "0" {
            result.text = ""
        }
        if let input = sender.titleLabel!.text {
            if ["0","1","2","3","4","5","6","7","8","9","+","-","*","/"].contains(input) {
                result.text! += input
            } else if input == "=" {
                if let resultNumber = calculate(expression: result.text!) {
                    result.text = String(resultNumber)
                }
            } else {
                result.text = "0"
            }
        }
    }
    

}

