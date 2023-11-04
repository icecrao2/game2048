//
//  ViewConst.swift
//  game2048
//
//  Created by sw on 2023/09/03.
//

import Foundation
import SwiftUI

struct ViewResources {
    
    static let palette1 = Color(hex: "F1DEC9")
    static let palette2 = Color(hex: "C8B6A6")
    static let palette3 = Color(hex: "A4907C")
    static let palette4 = Color(hex: "8D7B68")
    
    static let highlightButtonColor = Color(hex: "9A3B3B")
    
    
    static let boxColors: [Int: Color] = [
        -2: Color.purple,
        2: Color(hex: "EEE4DA"),
        4: Color(hex: "ECE0C8"),
        8: Color(hex: "F2B179"),
        16: Color(hex: "F59563"),
        32: Color(hex: "F67C5F"),
        64: Color(hex: "F65E3B"),
        128: Color(hex: "EDCF72"),
        256: Color(hex: "EDCC61"),
        512: Color(hex: "EDC850"),
        1024: Color(hex: "EDC53F"),
        2048: Color(hex: "EDC22E"),
        4096: Color(hex: "E0B515"),
        8192: Color(hex: "EDAC72"),
        16384: Color(hex: "ED965F"),
        32768: Color(hex: "ED7B3F"),
        65536: Color(hex: "FACD8A"),
        131072: Color(hex: "FAC965")
    ]
    
    static let textColors: [Int: Color] = [
        -2: .white,
        2: .white,
        4: .white,
        8: .white,
        16: .white,
        32: .white,
        64: .white,
        128: .white,
        256: .black,
        512: .black,
        1024: .black,
        2048: .black,
        4096: .black,
        8192: .black,
        16384: .black,
        32768: .black,
        65536: .black,
        131072: .black
    ]
}
