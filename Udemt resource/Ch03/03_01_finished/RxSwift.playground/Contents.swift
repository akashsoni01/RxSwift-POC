//: Please build the scheme 'RxSwiftPlayground' first

import RxSwift

example(of: "just") {
    
    let observable = Observable.just("Hello, world!")
    
    observable.subscribe({ (event: Event<String>) in
        print(event)
    })
}

example(of: "of") {
    
    let observable = Observable.of(1, 2, 3)
    
    observable.subscribe {
        print($0)
    }
}

example(of: "from") {
    
    let subscription = Observable.from([1, 2, 3])
        .subscribe(onNext: {
            print($0)
        })
    
    let disposeBag = DisposeBag()
    
    subscription.disposed(by: disposeBag)
    
    Observable.from([4, 5, 6])
        .subscribe(
            onNext: { print($0) },
            onCompleted: { print("Completed") },
            onDisposed: { print("Disposed") }
        )
        .disposed(by: disposeBag)
}

example(of: "error") {
    
    let disposeBag = DisposeBag()
    
    enum MyError: Error {
        case test
    }
    
    Observable<Void>.error(MyError.test)
        .subscribe(onError: {
            print($0)
        })
        .disposed(by: disposeBag)
}

/*:
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
