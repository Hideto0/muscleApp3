//
//  TrainningViewController.swift
//  muscleApp
//



//  Created by たかはしひでと on 2021/04/14.
//

import UIKit
import AudioToolbox
import AVFoundation

class TrainingViewController: UIViewController {

    @IBOutlet weak var resultTimer: UILabel!
    @IBOutlet weak var restTime: UILabel!
    @IBOutlet weak var passedSet: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    
    var player: AVAudioPlayer!
    var Time: String?
    var Rest: String?
    var Passed: String?
    var timer = Timer()
    var time = 0
    var time2 = 0
    var timer2 = Timer()
    var PassedSet = 0
    var RestTime = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultTimer.text = Time
        restTime.text = Rest
        passedSet.text = Passed
    
        pauseButton.isHidden = true
        finishButton.isHidden = true
        
    }
    @IBAction func startButtonPressed(_ sender: UIButton) {
        let PassedSet2 = passedSet.text!
        PassedSet = Int(PassedSet2)!
        
        pauseButton.isHidden = false
        finishButton.isHidden = false
        startButton.isHidden = true
        
        mainTimer()
            
        }
       
    
    @IBAction func pauseButtonPressed(_ sender: UIButton) {
        
        if sender.currentTitle == "Pause" {
            self.timer.invalidate()
            self.timer2.invalidate()
            pauseButton.setTitle("Resum", for: .normal)
        } else {
            if resultTimer.text == "0" {
                subTimer()
            }else {
                mainTimer()
        }
            pauseButton.setTitle("Pause", for: .normal)
    }
    }
    
    @IBAction func finishButtonPressed(_ sender: UIButton) {
        resultTimer.text = Time
        restTime.text = Rest
        passedSet.text = Passed
        
        startButton.isHidden = false
        finishButton.isHidden = true
        pauseButton.isHidden = true
        self.timer.invalidate()
        self.timer2.invalidate()
    }
        
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func mainTimer () {
        // 取得した値をIntに変換
        let time2 = resultTimer.text!
        time = Int(time2)!
        
        //トレーニング時間のタイマー
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (resultTimer) in
                        self.time -= 1
                self.resultTimer.text = String(self.time)
                
                if self.time == 0 {
                    self.timer.invalidate()

                    self.vibrate()
                    self.playSound()
                    self.subTimer()
                }
                    })
        }
    
    func subTimer() {
        
        let RestTime2 = restTime.text!
        RestTime = Int(RestTime2)!
        let PassedSet2 = passedSet.text!
        PassedSet = Int(PassedSet2)!
        //RestTimeのタイマー
        self.timer2 = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [self] (restTime) in
                    self.RestTime -= 1
            self.restTime.text = String(self.RestTime)
            print(self.time2)
            
            if self.RestTime == 0 {
                self.timer2.invalidate()
                self.PassedSet -= 1
                self.passedSet.text = String(self.PassedSet)
                self.vibrate()
                self.playSound()
                self.resultTimer.text = self.Time
                self.restTime.text = self.Rest
                if PassedSet > 0 {
                    mainTimer()
                } else {
                    self.passedSet.text = self.Passed
                    startButton.isHidden = false
                    finishButton.isHidden = true
                    pauseButton.isHidden = true
                }
                
            }
                })
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "chin", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player?.play()
    }
    
    func vibrate() {
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
}
