//
//  AppearanceProxy.swift
//  Themify
//
//  Created by Ronaldo Faria Lima on 28/04/17.
//
//

import Foundation
import UIKit

struct AppearanceProxy<Type: UIAppearance> {
    let container: UIAppearanceContainer.Type!
    
    init (container: UIAppearanceContainer.Type? = nil) {
        self.container = container
    }
    
    func appearance() -> Type {
        if container != nil {
            return Type.appearance(whenContainedInInstancesOf: [container])
        }
        return Type.appearance()
    }
}
