//
//  ViewController.swift
//  muscleApp
//
//  Created by たかはしひでと on 2021/04/10.
//
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var setNumber2: UITextField!
    @IBOutlet weak var secondsNumber2: UITextField!
    @IBOutlet weak var RestTime2: UITextField!
    
    var set = "0"
    var seconds = "0"
    var rest = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNumber2.delegate = self
        secondsNumber2.delegate = self
    }
    @IBAction func setNumber(_ sender: UITextField) {
        set = setNumber2.text!
    }
   
    @IBAction func secondsNumber(_ sender: UITextField) {
        seconds =  secondsNumber2.text!
    }
    
    @IBAction func RestTime(_ sender: UITextField) {
        rest = RestTime2.text!
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //Enterkeyを押したときにアクションを実行するコード
        setNumber2.endEditing(true)
        secondsNumber2.endEditing(true)
        RestTime2.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // textfieldの中身がnilだった時のコード
        if textField.text != ""{
            return true
        }else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    override func didReceiveMemoryWarning() {  //textfield外をタップした時にkeyboardを閉じるコード
           super.didReceiveMemoryWarning()
       }

       override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(true)
       }
    
    @IBAction func startButton(_ sender: UIButton) {
        _ = setNumber2.text!
        _ = secondsNumber2.text!
        
        self.performSegue(withIdentifier: "gotoTraining", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoTraining" {
            let destinationVC = segue.destination as! TrainingViewController
            destinationVC.Time = seconds 
            destinationVC.Rest = rest
            destinationVC.Passed = set
        }
    }
    
}

