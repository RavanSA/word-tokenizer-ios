//
//  Helper.swift
//  testproject
//
//  Created by Revan Sadigli on 7.01.2024.
//

import Foundation

extension String {
    func capitalizedFirstLetter() -> String {
        guard let first = first else { return self }
        return String(first).uppercased() + dropFirst()
    }
}
