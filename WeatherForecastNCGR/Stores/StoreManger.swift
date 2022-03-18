//
//  StoreManger.swift
//  WeatherForecastNCGR
//
//  Created by Mohamed Hashem on 18/03/2022.
//

import Foundation
import Realm

protocol StoreMangerProtocol: AnyObject {
    func save(file: Any)
    func Edit(file: Any)
    func delete(file: Any)
    func create(file: Any)
    func get(file: Any)
}

enum StoredType {
    case city
    case cityWithDay
}

class DefaultStoreManger: StoreMangerProtocol {
    func save(file: Any) {
        
    }
    
    func Edit(file: Any) {
        
    }
    
    func delete(file: Any) {
        
    }
    
    func create(file: Any) {
        
    }
    
    func get(file: Any) {
        
    }
}

class RealmStoreManger: StoreMangerProtocol {
    func save(file: Any) {
        
    }
    
    func Edit(file: Any) {
        
    }
    
    func delete(file: Any) {
        
    }
    
    func create(file: Any) {
        
    }
    
    func get(file: Any) {
        
    }
}
