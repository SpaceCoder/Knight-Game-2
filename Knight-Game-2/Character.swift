//
//  Character.swift
//  Knight-Game-2
//
//  Created by Anjam Nabil Islam on 12/25/15.
//  Copyright © 2015 Anjam. All rights reserved.
//

import Foundation

class Character {
    private var _hp: Int!
    private var _AttackPwr: Int!
    private var _name: String!
    
    var type: String {
        return ""
    }
    
    var hp: Int {
        return _hp
    }
    
    var AttackPwr: Int {
        return _AttackPwr
    }
    
    var name: String {
        return _name
    }
    
    init(name: String, hp: Int, AttackPwr: Int) {
        self._name = name
        self._hp = hp
        self._AttackPwr = AttackPwr
    }
    
    func RecievingAttack(AttackPwr: Int) {
        self._hp! -= AttackPwr
    }
}