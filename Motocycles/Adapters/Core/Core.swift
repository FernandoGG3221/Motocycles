//
//  Core.swift
//  Motocycles
//
//  Created by Fernando González González on 18/01/22.
//

import Foundation

class Core{
    
    static let shared = Core()
    
    func isNewUser() -> Bool{
        return UserDefaults.standard.bool(forKey: "userNew")
    }
    
    func setIsNotNewUser(){
        UserDefaults.standard.set(true, forKey: "userNew")
    }
    
}
