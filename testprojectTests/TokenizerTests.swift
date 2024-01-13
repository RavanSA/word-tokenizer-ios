//
//  TokenizerTests.swift
//  testprojectTests
//
//  Created by Revan SADIGLI on 13.01.2024.
//

import XCTest
@testable import testproject

class TokenizerTests: XCTestCase {

    func testTokenizeSentenceEnglish() {
        let tokenizer = Tokenizer()
        let input = "This is a sample sentence if it works"
        let expectedOutput = ["This is a sample sentence", "if it works"]
        
        let result = tokenizer.tokenizeSentence(input, language: .english)
        
        XCTAssertEqual(result, expectedOutput)
    }

    func testTokenizeSentenceSpanish() {
        let tokenizer = Tokenizer()
        let input = "Esto es una oración de ejemplo si funciona"
        let expectedOutput = ["Esto es una oración de ejemplo", "si funciona"]
        
        let result = tokenizer.tokenizeSentence(input, language: .spanish)
        
        XCTAssertEqual(result, expectedOutput)
    }

    func testTokenizeSentenceTurkish() {
        let tokenizer = Tokenizer()
        let input = "Bu bir örnek cümle eğer işe yararsa"
        let expectedOutput = ["Bu bir örnek cümle", "eğer işe yararsa"]
        
        let result = tokenizer.tokenizeSentence(input, language: .turkish)
        
        XCTAssertEqual(result, expectedOutput)
    }
}
