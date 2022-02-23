//
//  CommentFormTests.swift
//  FabulaTests
//
//  Created by Raphaël Goupille on 18/02/2022.
//

import XCTest
@testable import Fabula

class CommentFormTests: XCTestCase, SubmittedCommentDelegate {
    
    var comment: String?
    var expectation: XCTestExpectation?
    
    func testComment() throws {
        
        let manager = CommentForm()
        manager.submittedCommentDelegate = self
        
        manager.submitTapped()
        manager.submittedCommentDelegate?.commentSubmitted(comment: "paul")
        
        XCTAssertEqual(comment, "paul")
    }
    
    func commentSubmitted(comment: String) {
        self.comment = comment
    }


}
