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
        let data = UserDefaults.standard.bool(forKey: "isNewUser")
        print("\n\nUserDefault", data)
        //print("UserDefault", !data)
        print("\n\n")
        return data
    }
    
    func setIsNotNewUser(){
        
        UserDefaults.standard.set(true, forKey: "isNewUSer")
    }
    
}
