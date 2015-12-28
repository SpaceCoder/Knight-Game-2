//
//  ViewController.swift
//  Knight-Game-2
//
//  Created by Anjam Nabil Islam on 12/25/15.
//  Copyright © 2015 Anjam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //Properties
    enum Status {
        case ChoosingPlayer
        case GameInProgress
        case GameEnded
    }
    var player1: Character?
    var player2: Character?
    var GameStatus: Status = Status.ChoosingPlayer

    
    //Outlets
    @IBOutlet weak var ScreenOutput: UILabel!
    @IBOutlet weak var Player1Img: UIImageView!
    @IBOutlet weak var Player2Img: UIImageView!
    @IBOutlet weak var Player1HP: UILabel!
    @IBOutlet weak var Player2HP: UILabel!
    @IBOutlet weak var Player1Btn: UIButton!
    @IBOutlet weak var Player2Btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        AsktoChoosePlayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //IBActions
   
    @IBAction func Player1BtnPressed() {
        
        if GameStatus == Status.GameInProgress {
            if let one = player1, two = player2 {
                Attack(one, Defender: two)
            }
            DisableBtn(Player2Btn)
        }
        
        AssignKnight()
        AsktoChoosePlayer()
        UpdateHP()
        Restart()
    }
    
    @IBAction func Player2BtnPressed() {
        
        if GameStatus == Status.GameInProgress {
            
            if let one = player1, two = player2 {
                Attack(two, Defender: one)
            }
            DisableBtn(Player1Btn)
        }
        
        AssignOger()
        AsktoChoosePlayer()
        UpdateHP()
        Restart()
    }
    
    //Functions
    
    func AsktoChoosePlayer() {
        
        if GameStatus == Status.ChoosingPlayer {
            if player1 == nil && player2 == nil {
                ChoosePlayer1()
            } else if player2 == nil {
                ScreenOutput.text = "Player 2, choose your character"
            } else {
                Player1Btn.setTitle("ATTACK", forState: UIControlState.Normal)
                Player2Btn.setTitle("ATTACK", forState: UIControlState.Normal)
                ScreenOutput.text = "Attack your foe!"
                GameStatus = Status.GameInProgress
            }
        }
    }
    
    func ChoosePlayer1() {
        Player1Btn.setTitle("Knight", forState: UIControlState.Normal)
        Player2Btn.setTitle("Oger", forState: UIControlState.Normal)
        Player1Img.image = UIImage(named: "knight1")
        Player2Img.image = UIImage(named: "oger2")
        ScreenOutput.text = "Player 1, choose your character"
        Player1HP.text = ""
        Player2HP.text = ""
    }
    
    func AssignKnight() {
        if GameStatus == Status.ChoosingPlayer {
            if player1 == nil {
                player1 = Knight(name: "Player 1", hp: 100, AttackPwr: 20)
                Player1Img.image = UIImage(named: "knight1")
                Player2Img.hidden = true
            } else if player2 == nil {
                player2 = Knight(name: "Player 2", hp: 100, AttackPwr: 20)
                Player2Img.image = UIImage(named: "knight2")
                Player2Img.hidden = false
            }
        }
    }
    
    func AssignOger() {
        if GameStatus == Status.ChoosingPlayer {
            if player1 == nil {
                player1 = Oger(name: "Player 2", hp: 200, AttackPwr: 10)
                Player1Img.image = UIImage(named: "oger1")
                Player2Img.hidden = true
            } else if player2 == nil {
                player2 = Oger(name: "Player 2", hp: 200, AttackPwr: 10)
                Player2Img.image = UIImage(named: "oger2")
                Player2Img.hidden = false
            }
        }
    }
    
    func UpdateHP() {
        if let p = player1 {
            Player1HP.text = "\(p.hp) hp"
        }
        
        if let q = player2 {
            Player2HP.text = "\(q.hp) hp"
        }
    }
    
    func Attack(Attacker: Character, Defender: Character) {
        Defender.RecievingAttack(Attacker.AttackPwr)
        ScreenOutput.text = "\(Attacker.name) attacked \(Defender.name)"
        EndGame(Attacker, Defender: Defender)
    }
    
    func EndGame(Attacker: Character, Defender: Character) {
        if Defender.IsAlive == false {
            ScreenOutput.text = "\(Attacker.name) won!"
            Player1Btn.setTitle("Restart", forState: UIControlState.Normal)
            Player2Btn.setTitle("Restart", forState: UIControlState.Normal)
            EnableBtn()
            GameStatus = Status.GameEnded
        }
    }
    
    func Restart() {
        if GameStatus == Status.GameEnded {
            if player1 == nil && player2 == nil {
                GameStatus = Status.ChoosingPlayer
                ChoosePlayer1()
            }
            player1 = nil
            player2 = nil
            }
    }
    
    func DisableBtn(btn: UIButton) {
        btn.enabled = false
        btn.setBackgroundImage(UIImage(named: "player2attackbtn"), forState: UIControlState.Normal)
        NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "EnableBtn", userInfo: nil, repeats: false)
    }

    
    func EnableBtn() {
        if Player1Btn.enabled == false {
            Player1Btn.enabled = true
            Player1Btn.setBackgroundImage(UIImage(named: "player1attackbtn"), forState: UIControlState.Normal)
        } else if Player2Btn.enabled == false {
            Player2Btn.enabled = true
            Player2Btn.setBackgroundImage(UIImage(named: "player1attackbtn"), forState: UIControlState.Normal)

        }
    }
}

