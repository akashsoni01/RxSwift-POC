/*
 Copyright © 2017 Optimac, Inc. All rights reserved.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import XCTest
import RxSwift
import RxTest
import RxBlocking

class TestingTests: XCTestCase {
    
    var scheduler: TestScheduler!
    var subscription: Disposable!
    
    override func setUp() {
        super.setUp()
        
        scheduler = TestScheduler(initialClock: 0)
    }
    
    override func tearDown() {
        scheduler.scheduleAt(1000) {
            self.subscription.dispose()
        }
        
        super.tearDown()
    }
    
    func testMap() {
        let observer = scheduler.createObserver(Int.self)
        
        let observable = scheduler.createHotObservable([
            next(100, 1),
            next(200, 2),
            next(300, 3)
            ])
        
        let mapObservable = observable.map { $0 * 2 }
        
        scheduler.scheduleAt(0) {
            self.subscription = mapObservable.subscribe(observer)
        }
        
        scheduler.start()
        
        let results = observer.events.map {
            $0.value.element!
        }
        
        XCTAssertEqual(results, [2, 4, 6])
    }
    
    func testMapCold() {
        let disposeBag = DisposeBag()
        
        let observerA = scheduler.createObserver(Int.self)
        let observerB = scheduler.createObserver(Int.self)
        
        let observable = scheduler.createColdObservable([
            next(100, 1),
            next(200, 2),
            next(300, 3)
            ])
        
        let mapObservableA = observable.map { $0 * 2 }
        let mapObservableB = observable.map { $0 * 3 }
        
        scheduler.scheduleAt(0) {
            mapObservableA.subscribe(observerA).disposed(by: disposeBag)
        }
        
        scheduler.scheduleAt(150) {
            mapObservableB.subscribe(observerB).disposed(by: disposeBag)
        }
        
        scheduler.start()
        
        var results = observerA.events.map {
            $0.value.element!
        }
        
        _ = observerB.events.map {
            results.append($0.value.element!)
        }
        
        XCTAssertEqual(results, [2, 4, 6, 3, 6, 9])
    }
    
    func testMapHot() {
        let disposeBag = DisposeBag()
        
        let observerA = scheduler.createObserver(Int.self)
        let observerB = scheduler.createObserver(Int.self)
        
        let observable = scheduler.createHotObservable([
            next(100, 1),
            next(200, 2),
            next(300, 3)
            ])
        
        let mapObservableA = observable.map { $0 * 2 }
        let mapObservableB = observable.map { $0 * 3 }
        
        scheduler.scheduleAt(0) {
            mapObservableA.subscribe(observerA).disposed(by: disposeBag)
        }
        
        scheduler.scheduleAt(150) {
            mapObservableB.subscribe(observerB).disposed(by: disposeBag)
        }
        
        scheduler.start()
        
        var results = observerA.events.map {
            $0.value.element!
        }
        
        _ = observerB.events.map {
            results.append($0.value.element!)
        }
        
        XCTAssertEqual(results, [2, 4, 6, 6, 9])
    }
    
    func testBlocking() {
        let observable = Observable.of(1, 2, 3)
        
//        do {
//            let result = try observable.toBlocking().first()
//            XCTAssertEqual(result, 1)
//        } catch {
//            XCTFail(error.localizedDescription)
//        }
        
        XCTAssertEqual(try! observable.toBlocking().first(), 1)
    }
    
    func testToArray() {
        let scheduler = ConcurrentDispatchQueueScheduler(qos: .background)
        
        let observable = Observable.of(1, 2, 3)
            .map { $0 * 2 }
            .subscribeOn(scheduler)
        
        subscription = observable.subscribe { print($0) }
        print("--")
        
        do {
            let result = try observable.observeOn(MainScheduler.instance).toBlocking().toArray()
            XCTAssertEqual(result, [2, 4, 6])
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
