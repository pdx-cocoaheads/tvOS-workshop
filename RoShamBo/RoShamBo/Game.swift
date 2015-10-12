//
//  Choice.swift
//  RoShamBo
//
//  Created by Ryan Arana on 3/26/15.
//  Copyright (c) 2015 PDX-iOS. All rights reserved.
//

import Foundation

enum Verb: String {
    case draw = "-draw-"
    case crushes
    case disproves
    case covers
    case cuts
    case decapitates
    case vaporizes
    case eats
    case poisons

    init(_ game: Game) {
        guard game.winner != game.loser else { self = .draw; return }
        switch (game.winner, game.loser) {
        case (.Rock, .Scissors), (.Rock, .Lizard):
            self = .crushes
        case (.Paper, .Rock):
            self = .covers
        case (.Paper, .Spock):
            self = .disproves
        case (.Scissors, .Paper):
            self = .cuts
        case (.Scissors, .Lizard):
            self = .decapitates
        case (.Lizard, .Spock):
            self = .poisons
        case (.Lizard, .Paper):
            self = .eats
        case (.Spock, .Rock), (.Spock, .Scissors):
            self = .vaporizes
        default:
            preconditionFailure("Invalid winner/loser combination: \(game.winner) does not beat \(game.loser)")
        }
    }
}

enum Choice: Int {
    case Rock = 1
    case Paper
    case Scissors
    case Spock
    case Lizard

    var name: String {
        switch self {
        case .Rock:
            return "rock"
        case .Paper:
            return "paper"
        case .Scissors:
            return "scissors"
        case .Spock:
            return "spock"
        case .Lizard:
            return "lizard"
        }
    }

    static func all() -> [Choice] {
        return [.Rock, .Paper, .Scissors, .Spock, .Lizard]
    }

    static func random() -> Choice {
        let c = Int(arc4random_uniform(UInt32(5))) + 1
        return Choice(rawValue: c)!
    }
}

struct Game {
    let winner: Choice
    let loser: Choice
    var draw: Bool { return winner == loser }
    var verb: String { return Verb(self).rawValue }

    init(choices p1: Choice, _ p2: Choice) {
        guard p1 != p2 else {
            winner = p1
            loser = p2
            return
        }
        let higher = p1.rawValue > p2.rawValue ? p1 : p2
        let lower = higher == p1 ? p2 : p1
        
        if p1.rawValue % 2 == p2.rawValue % 2 {
            // If both are odd or both are even, the lower one wins
            winner = lower
            loser = higher
        } else {
            // Otherwise the higher one wins
            winner = higher
            loser = lower
        }
    }

    static func play(choice: Choice) -> Game {
        return Game(choices: choice, Choice.random())
    }

    var summary: String {
        if draw {
            return verb.capitalizedString
        }
        return "\(winner.name.capitalizedString) \(verb) \(loser.name.capitalizedString)."
    }
}
