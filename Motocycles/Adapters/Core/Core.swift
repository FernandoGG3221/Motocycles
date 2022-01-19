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
        print()
        return UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
    func setIsNotNewUser(){
        UserDefaults.standard.set(true, forKey: "isNewUSer")
    }
    
}
