//
//  HandleTestTests.swift
//  HandleTestTests
//
//  Created by ky0me22 on 2020/08/11.
//  Copyright © 2020 ky0me22. All rights reserved.
//

@testable import HandleTest
import XCTest
import Domain

class HandleTestTests: XCTestCase {

    let hoge = Hoge()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDomain() throws {
        let str = hoge.method(value1: 0, value2: 0, value3: 0)
        XCTAssertEqual(str, "domain-method")
    }

    func testNotDomain() throws {
        let str = hoge.method(value1: 0, value3: 0)
        XCTAssertEqual(str, "not-domain-method")
    }

    // value2 が必要とされない限りDomainではないほうのExtension Methodが呼ばれる
    // つまり、同名のmethodがExtensionで実装されている場合は、
    // 定義上なるべく引数の少ない方のメソッドが選択されて実行される
    func testAllPattern() throws {
        var str = ""
        // domain-methodのパターン
        str = hoge.method(value1: 0, value2: 0, value3: 0)
        XCTAssertEqual(str, "domain-method")
        str = hoge.method(value2: 0, value3: 0)
        XCTAssertEqual(str, "domain-method")
        str = hoge.method(value1: 0, value2: 0)
        XCTAssertEqual(str, "domain-method")
        str = hoge.method(value2: 0)
        XCTAssertEqual(str, "domain-method")

        // not-domain-methodのパターン
        str = hoge.method(value1: 0, value3: 0)
        XCTAssertEqual(str, "not-domain-method")
        str = hoge.method(value1: 0)
        XCTAssertEqual(str, "not-domain-method")
        str = hoge.method(value3: 0)
        XCTAssertEqual(str, "not-domain-method")
        str = hoge.method()
        XCTAssertEqual(str, "not-domain-method")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
