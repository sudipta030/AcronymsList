//
//  AcronymsListTests.swift
//  AcronymsListTests
//
//  Created by Sudipta on 29/09/21.
//

import XCTest
@testable import AcronymsList

class AcronymsListTests: XCTestCase {
    private var viewModel: AcronymsViewModel?
    override func setUpWithError() throws {
        viewModel = AcronymsViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testStringValidation() {
        let value = viewModel?.stringValidation(str: "") ?? false
        XCTAssertTrue(value)
    }
    // Asynchronous test: success fast, failure slow
    func testValidApiCallGetsHTTPStatusCode200() throws {
      // given
      let urlString =
        "http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=HMM"
      let url = URL(string: urlString)!
      // 1
      let promise = expectation(description: "Status code: 200")

      // when
        let dataTask = URLSession.shared.dataTask(with: url) { _, response, error in
        // then
        if let error = error {
          XCTFail("Error: \(error.localizedDescription)")
          return
        } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
          if statusCode == 200 {
            // 2
            promise.fulfill()
          } else {
            XCTFail("Status code: \(statusCode)")
          }
        }
      }
      dataTask.resume()
      // 3
      wait(for: [promise], timeout: 5)
    }
   

}
