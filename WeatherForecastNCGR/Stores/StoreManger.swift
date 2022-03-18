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
    func get() -> Any?
}

enum StoredType {
    case city
    case cityWithDay
}

class DefaultHomeModelManger: StoreMangerProtocol {
    func save(file: Any) {
        if let data = file as? [HomeResponseModel] {
            let encoder = JSONEncoder()
            let objectData = try? encoder.encode(data)
            UserDefaults.standard.setValue(objectData, forKey: "HomeResponseModel")
            UserDefaults.standard.synchronize()
        }
    }
    
    func Edit(file: Any) {
        
    }
    
    func delete(file: Any) {
        
    }
    
    func get() -> Any? {
        let userObject = UserDefaults.standard.data(forKey: "HomeResponseModel")
        if userObject != nil {
            let currentUser = try? JSONDecoder().decode([HomeResponseModel].self, from: userObject!)
            return currentUser
        } else {
            return nil
        }
    }
}

class DefaultCityModelManger {
    
    func getCity() -> [String]? {
        UserDefaults.standard.object(forKey: "NewCity") as? [String]
    }
    
    func setNewCity(city: [String]) {
        UserDefaults.standard.set(city, forKey: "NewCity")
    }
}

class RealmStoreManger: StoreMangerProtocol {
    func save(file: Any) {
       
    }
    
    func Edit(file: Any) {
        
    }
    
    func delete(file: Any) {
        
    }
    
    func get() -> Any? {
        return nil
    }
}
