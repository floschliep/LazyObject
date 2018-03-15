//
//  LazyObjectTests.swift
//  Tests
//
//  Created by Florian Schliep on 15.03.18.
//

import XCTest

class Foo { }

struct Bar {
    var message = "test"
}

class LazyObjectTests: XCTestCase {

    func testClosureNotCalledWhenObjectNotAccessed() {
        var closureCalled = false
        let lazyFoo = LazyObject() { () -> Foo in
            closureCalled = true
            return Foo()
        }
        XCTAssertFalse(closureCalled)
        print(lazyFoo)
        _ = lazyFoo
        XCTAssertFalse(closureCalled)
        _ = lazyFoo.object
        XCTAssertTrue(closureCalled)
    }
    
    func testClosureCalledOnce() {
        var calledCount = 0
        let lazyFoo = LazyObject() { () -> Foo in
            calledCount += 1
            return Foo()
        }
        _ = lazyFoo.object
        XCTAssertEqual(calledCount, 1)
        _ = lazyFoo.object
        XCTAssertEqual(calledCount, 1)
        
    }
    
    func testObjectAlwaysIdentical() {
        let lazyFoo = lazy(Foo())
        let object1 = lazyFoo.object
        let object2 = lazyFoo.object
        XCTAssertTrue(object1 === object2)
        XCTAssertTrue(object1 === lazyFoo.object)
    }
    
    func testMutation() {
        let lazyBar = mutableLazy(Bar())
        XCTAssertEqual(lazyBar.object.message, "test")
        lazyBar.use { $0.message = "hello" }
        XCTAssertEqual(lazyBar.object.message, "hello")
    }

}
