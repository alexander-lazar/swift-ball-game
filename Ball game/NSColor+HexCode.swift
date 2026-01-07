//
//  NSColor+HexCode.swift
//  Ball game
//
//  Created by Alexander Lazar on 07.01.26.
//

import Foundation
import AppKit

extension NSColor {
    static func fromHexCode(_ code: String) -> NSColor? {
        var hex = code.trimmingCharacters(in: .whitespacesAndNewlines)
        hex = hex.replacingOccurrences(of: "#", with: "")

        guard hex.count == 6 || hex.count == 8 else {
            return nil
        }

        var hexNumber: UInt64 = 0
        guard Scanner(string: hex).scanHexInt64(&hexNumber) else {
            return nil
        }

        let r, g, b, a: CGFloat

        if hex.count == 6 {
            r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255
            g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255
            b = CGFloat(hexNumber & 0x0000FF) / 255
            a = 1.0
        } else {
            r = CGFloat((hexNumber & 0xFF000000) >> 24) / 255
            g = CGFloat((hexNumber & 0x00FF0000) >> 16) / 255
            b = CGFloat((hexNumber & 0x0000FF00) >> 8) / 255
            a = CGFloat(hexNumber & 0x000000FF) / 255
        }

        return NSColor(red: r, green: g, blue: b, alpha: a)
    }
}
