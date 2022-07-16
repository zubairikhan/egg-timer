//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var secondsPassed = 0
    var timeToBoil = 0
    var timer = Timer()
    
    let eggTimes = ["Soft": 3, "Medium": 5, "Hard": 7]
    var player : AVAudioPlayer!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        progressBar.progress = 0
        secondsPassed = 0
        timer.invalidate()
        
        let hardness = sender.currentTitle!
      
        timeToBoil = eggTimes[hardness]!
        titleLabel.text = hardness

        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
            
    }
    
    @objc func updateCounter() {
        if secondsPassed < timeToBoil {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(timeToBoil)
        }
        else {
            timer.invalidate()
            titleLabel.text = "Done"
            playSound()
        }
    }
    
    func playSound(){
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
