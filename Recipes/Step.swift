//
//  Item.swift
//  Recipes
//
//  Created by Zach Barton on 12/4/23.
//

import Foundation
import SwiftData

@Model
final class Step {
    var stepNum: Int
    var title: String
    var instruction: String
    
    init(stepNum: Int, title: String, instruction: String) {
        self.title = title
        self.stepNum = stepNum
        self.instruction = instruction
    }
}
