//: Please build the scheme 'RxSwiftPlayground' first

import RxSwift

example(of: "PublishSubject") {
    
    let subject = PublishSubject<String>()
    
    let disposeBag = DisposeBag()
    
    subject.subscribe {
        print($0)
        }
        .disposed(by: disposeBag)
    
    enum MyError: Error {
        case test
    }
    
    subject.on(.next("Hello"))
    
//    subject.onCompleted()
    
//    subject.onError(MyError.test)
    
    subject.onNext("World")
    
    let newSubscription = subject.subscribe(onNext: {
        print("New subscription:", $0)
    })
    
    subject.onNext("What's up?")
    
    newSubscription.dispose()
    
    subject.onNext("Still there?")
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
