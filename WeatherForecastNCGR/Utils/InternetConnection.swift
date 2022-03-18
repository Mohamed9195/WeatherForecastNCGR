//
//  InternetConnection.swift
//  CountryFood
//
//  Created by Mohamed Hashem on 18/03/2022.
//

import Network

class InternetConnection {
    
    static let shared = InternetConnection()

    func startListening(_ reachableClosure:@escaping (ConnectionStatus) -> Void = { _ in }) {

        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "InternetConnectionMonitor")

        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                DispatchQueue.main.async {
                    reachableClosure(.connected)
                }

            } else {
                DispatchQueue.main.async {
                    reachableClosure(.disConnected)
                }
            }
        }
        monitor.start(queue: queue)
    }
}

enum ConnectionStatus {
    case connected
    case disConnected
}
