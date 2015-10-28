//
//  ViewController.swift
//  retro-calculator
//
//  Created by Mark Price on 8/1/15.
//  Copyright © 2015 devslopes. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var counterLabel: UILabel!
    
    enum Operation: String {
        
        case add = "+"
        case subtract = "-"
        case divide = "/"
        case multiply = "*"
        case empty = "empty"
        
    }
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber: String = ""
    var leftValue: String = ""
    var rightValue: String = ""
    var currentOpeation: Operation = Operation.empty
    var sum = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    @IBAction func numberPadPressed(btn: UIButton!) {
        
        buttonSound()
        
        runningNumber += "\(btn.tag)"
        counterLabel.text = runningNumber
        
    }

    @IBAction func isDividePressed(sender: AnyObject) {
       processOperation(Operation.divide)
    }
    
    @IBAction func isMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.multiply)
    }
    
    @IBAction func isMinusPresed(sender: AnyObject) {
        processOperation(Operation.subtract)
    }
    
    @IBAction func isAddPressed(sender: AnyObject) {
       processOperation(Operation.add)
    }
    
    @IBAction func isEqualPressed(sender: AnyObject) {
        processOperation(currentOpeation)
    }
    
    func buttonSound() {
        
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
        
    }
    
    func processOperation(op: Operation) {
        
        if currentOpeation == Operation.empty {
            
            // first time operation is pressed
            leftValue = runningNumber
            runningNumber = ""
            currentOpeation = op
            
        } else {
            
            //do maths
            
            if runningNumber != "" {
            rightValue = runningNumber
            runningNumber = ""
            
            if currentOpeation == Operation.add {
                sum = "\(Double(leftValue)! + Double(rightValue)!)"
            } else if currentOpeation == Operation.subtract {
                sum = "\(Double(leftValue)! - Double(rightValue)!)"
            } else if currentOpeation == Operation.multiply {
                sum = "\(Double(leftValue)! * Double(rightValue)!)"
            } else if currentOpeation == Operation.divide {
                sum = "\(Double(leftValue)! / Double(rightValue)!)"
            }
            
            }
            counterLabel.text = sum
            leftValue = sum
            
            currentOpeation = op
            
        }
        
        
        
        
        
    }
    
}