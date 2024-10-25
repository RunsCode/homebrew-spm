//
//  File.swift
//  
//
//  Created by 王亚军 on 2024/9/18.
//

import Foundation
/*
 •    1: 粗体
 •    3: 斜体
 •    4: 下划线
 */

public enum Log: String {
    case `default` = "0"
    case red = "31"
    case green = "32"
    case yellow = "33"
    case blue = "34"
    case purple = "35"
    case cyan = "36"
    case white = "37"
    
    enum Weight: String {
        case `default` = "0"
        case bold = "1"
        case italic = "3"
        case underline = "4"
    }
        
    func callAsFunction(_ text: String, _ weight: Weight = .bold) {
        print("\u{001B}[\(weight.rawValue);\(self.rawValue)m\(text)\u{001B}[0m")
    }
}
