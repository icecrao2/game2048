//
//  NavigationManager.swift
//  game2048
//
//  Created by sw on 2023/09/03.
//


import Foundation
import SwiftUI

class NavigationManager: ObservableObject {
    
    @Published var path: NavigationPath
    
    let goSemaphore = DispatchSemaphore(value: 1)
    let backSemaphore = DispatchSemaphore(value: 1)
    
    enum ViewCode: Int {
        
        case MainView = 1
        case GameView = 2
        
        case EmptyView = 200
    }
    
    static func readSerializedData() -> Data? {
        // Read data representing the path from app's persistent storage.
        return nil
    }
        
    static func writeSerializedData(_ data: Data) {
        // Write data representing the path to app's persistent storage.
    }

    func go(_ view: ViewCode) {
        
        goSemaphore.wait()
        
        path.append(view.rawValue)
        
        goSemaphore.signal()
    }
    
    
    func back() {
        backSemaphore.wait()
        
        if path.isEmpty {
        } else {
            path.removeLast()
        }
        
        backSemaphore.signal()
    }
    
    func backToRoot() {
        backSemaphore.wait()
        
        path = .init()
        
        backSemaphore.signal()
    }
    
    init() {
        if let data = Self.readSerializedData() {
            do {
                let representation = try JSONDecoder().decode(
                    NavigationPath.CodableRepresentation.self,
                    from: data)
                self.path = NavigationPath(representation)
            } catch {
                self.path = NavigationPath()
            }
        } else {
            self.path = NavigationPath()
        }
    }

    func save() {
        
        guard let representation = path.codable else { return }
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(representation)
            Self.writeSerializedData(data)
        } catch {
            // Handle error.
        }
    }

}
