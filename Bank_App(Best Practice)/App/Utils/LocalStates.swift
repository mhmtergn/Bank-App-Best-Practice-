//
//  LocalStates.swift
//  Bank_App(Best Practice)
//
//  Created by Mehmet Ergun on 1/30/26.
//

import Foundation



public class LocalState {
    private enum Keys: String {
        case hasOnboarded
        case hasLogined
    }
    
    public static var hasOnboarded: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.hasOnboarded.rawValue)
        }
        
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.hasOnboarded.rawValue)
        }
    }
    
    public static var hasLogined: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.hasLogined.rawValue)
        }
        
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.hasLogined.rawValue)
        }
    }
}
