//: Please build the scheme 'RxSwiftPlayground' first

import RxSwift
import RxCocoa

example(of: "catchErrorJustReturn") {
    
    let disposeBag = DisposeBag()
    
    let subject = PublishSubject<String>()
    
    subject
        .catchErrorJustReturn("😊")
        .subscribe { print($0) }
        .disposed(by: disposeBag)
    
    subject.onNext("Hello, world!")
    
    subject.onError(MyError.test)
}

example(of: "catchError") {
    
    let disposeBag = DisposeBag()
    
    let subject = PublishSubject<String>()
    
    let recovery = PublishSubject<String>()
    
    subject
        .catchError {
            print("Error:", $0)
            return recovery
        }
        .subscribe { print($0) }
        .disposed(by: disposeBag)
    
    subject.onNext("Hello, world!")
    
    subject.onError(MyError.test)
    
    subject.onNext("Still there?")
    
    recovery.onNext("Don't worry, I've got this!")
}

example(of: "retry") {
    
    let disposeBag = DisposeBag()
    
    var shouldEmitError = true
    
    let observable = Observable<Int>.create { observer in
        observer.onNext(1)
        observer.onNext(2)
        
        if shouldEmitError {
            observer.onError(MyError.test)
            shouldEmitError = false
        }
        
        observer.onNext(3)
        observer.onCompleted()
        
        return Disposables.create()
    }
    
    observable
        .retry(2)
        .subscribe { print($0) }
        .disposed(by: disposeBag)
}

example(of: "Driver onErrorJustReturn") {
    
    let disposeBag = DisposeBag()
    
    let subject = PublishSubject<Int>()
    
    subject.asDriver(onErrorJustReturn: 1000)
        .drive(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
    
    subject.onNext(1)
    subject.onNext(2)
    
    subject.onError(MyError.test)
    
    subject.onNext(3)
}

example(of: "Driver onErrorDriveWith") {
    
    let disposeBag = DisposeBag()
    
    let subject = PublishSubject<Int>()
    
    let recovery = PublishSubject<Int>()
    
    subject.asDriver(onErrorDriveWith: recovery.asDriver(onErrorJustReturn: 1000))
        .drive(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
    
    subject.onNext(1)
    subject.onNext(2)
    
    subject.onError(MyError.test)
    
    subject.onNext(3)
    
    recovery.onNext(10)
}

print("--- Example of: Driver onErrorRecover ---")

import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

let disposeBag = DisposeBag()

let subject = PublishSubject<Int>()

subject.asDriver {
    print("Error:", $0)
    return Driver.just(1000)
    }
    .drive(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

subject.onNext(1)
subject.onNext(2)

subject.onError(MyError.test)

subject.onNext(3)

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
