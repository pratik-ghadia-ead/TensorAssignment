//
//  DataTypeExtension.swift
//  TensorAssignment
//
//  Created by EAD on 10/10/23.
//

import Foundation

extension String {
    var stripped: String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890")
        return self.filter {okayChars.contains($0) }
    }
}

extension Double {
    func roundDouble() -> String {
        return String(format: "%.0f", self)
    }
}
