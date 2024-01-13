//
//  Tokenizer.swift
//  testproject
//
//  Created by Revan SADIGLI on 13.01.2024.
//

import Foundation

enum SupportedLanguages {
    case english
    case spanish
    case turkish
}

class Tokenizer {
    
    func tokenizeSentence(_ sentence: String, language: SupportedLanguages) -> [String] {
        var separatorEnglish: [String] = []
        
        switch language {
        case .english:
            separatorEnglish = ["if", "and"]
        case .spanish:
            separatorEnglish = ["si", "y"]
        case .turkish:
            separatorEnglish = ["eğer", "ve"]
        }
        
        var tokenizedStrings: [String] = []
        var currentSegment = ""
        
        for char in sentence {
            let charStr = String(char)
            
            currentSegment += charStr
            
            for separator in separatorEnglish {
                if currentSegment.lowercased().hasSuffix(separator) {
                    currentSegment = String(currentSegment.dropLast(separator.count))
                    
                    tokenizedStrings.append(currentSegment.trimmingCharacters(in: .whitespacesAndNewlines))
                    
                    currentSegment = separator
                    break
                }
            }
        }
        
        if !currentSegment.isEmpty {
            tokenizedStrings.append(currentSegment.trimmingCharacters(in: .whitespacesAndNewlines))
        }
        
        return tokenizedStrings
    }
}
