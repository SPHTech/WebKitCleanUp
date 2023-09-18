//
//  Model.swift
//  TestUtilsExample
//
//  Created by Hoang Nguyen on 18/9/23.
//

import Foundation

final class ChildModel {
    let name: String
    var parent: ParentModel!
    
    init(name: String) {
        self.name = name
    }
}

final class ParentModel {
    let name: String
    var child: ChildModel!
    
    init(name: String) {
        self.name = name
    }
}
