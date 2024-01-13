//
//  TokenizerTests.swift
//  testprojectTests
//
//  Created by Revan SADIGLI on 13.01.2024.
//

import XCTest
@testable import testproject

class TokenizerTests: XCTestCase {

    var tokenizer: Tokenizer!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        tokenizer = Tokenizer()
    }
    
    override func tearDownWithError() throws {
        tokenizer = nil
    }
    
    func testTokenizeSentenceEnglish() {
        // Given
        let input = "This is a sample sentence if it works"
        let expectedOutput = ["This is a sample sentence", "if it works"]
        
        // When
        let result = tokenizer.tokenizeSentence(input, language: .english)
        
        // Then
        XCTAssertEqual(result, expectedOutput)
    }

    func testTokenizeSentenceSpanish() {
        // Given
        let input = "Esto es una oración de ejemplo si funciona"
        let expectedOutput = ["Esto es una oración de ejemplo", "si funciona"]
        
        // When
        let result = tokenizer.tokenizeSentence(input, language: .spanish)
        
        // Then
        XCTAssertEqual(result, expectedOutput)
    }

    func testTokenizeSentenceTurkish() {
        // Given
        let input = "Bu bir örnek cümle eğer işe yararsa"
        let expectedOutput = ["Bu bir örnek cümle", "eğer işe yararsa"]
        
        // When
        let result = tokenizer.tokenizeSentence(input, language: .turkish)
        
        // Then
        XCTAssertEqual(result, expectedOutput)
    }
    
}
