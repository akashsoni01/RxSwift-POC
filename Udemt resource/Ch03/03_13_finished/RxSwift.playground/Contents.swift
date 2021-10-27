//: Please build the scheme 'RxSwiftPlayground' first

import RxSwift

example(of: "startWith") {
    
    let disposeBag = DisposeBag()
    
    Observable.of("A", "B", "C")
        .startWith("1")
        .startWith("2")
        .startWith("3", "4")
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
}

example(of: "merge") {
    
    let subject1 = PublishSubject<String>()
    
    let subject2 = PublishSubject<String>()
    
    let disposeBag = DisposeBag()
    
    Observable.of(subject1, subject2)
        .merge()
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
    
    subject1.onNext("A")
    
    subject2.onNext("1")
    
    subject1.onNext("B")
    
    subject2.onNext("2")
}

example(of: "zip") {
    
    let stringSubject = PublishSubject<String>()
    
    let intSubject = PublishSubject<Int>()
    
    let disposeBag = DisposeBag()
    
    Observable.zip(stringSubject, intSubject) { string, int in
        "\(string) \(int)"
        }
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
    
    stringSubject.onNext("A")
    
    stringSubject.onNext("B")
    
    intSubject.onNext(1)
    
    intSubject.onNext(2)
    
    intSubject.onNext(3)
    
    stringSubject.onNext("C")
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
