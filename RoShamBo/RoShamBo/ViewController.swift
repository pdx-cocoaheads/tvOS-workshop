//
//  ViewController.swift
//  RoShamBo
//
//  Created by Ryan Arana on 10/6/15.
//  Copyright © 2015 PDX-iOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var selectedButton: UIButton? {
        didSet {
            oldValue?.highlighted = false
            selectedButton?.highlighted = true
        }
    }

    @IBOutlet weak var inputsView: UIView!

    @IBOutlet weak var resultsView: UIStackView!
    @IBOutlet weak var winnerImage: UIImageView!
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var loserImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        resultsView.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonClicked(sender: UIButton) {
        selectedButton = sender

        let playerChoice = Choice(rawValue: sender.tag)!
        let result = Game.play(playerChoice)
        resultsView.hidden = false

        if playerChoice == result.winner {
            winnerImage.image = UIImage(named: "\(result.winner.name)-highlighted")
        } else {
            winnerImage.image = UIImage(named: result.winner.name)
        }

        if playerChoice == result.loser {
            loserImage.image = UIImage(named: "\(result.loser.name)-highlighted")
        } else {
            loserImage.image = UIImage(named: result.loser.name)
        }

        actionLabel.text = result.summary
    }
}

