//: Please build the scheme 'RxSwiftPlayground' first

import RxSwift

example(of: "do(on...:)") {
    
    let fahrenheitTemps = PublishSubject<Int>()
    
    let disposeBag = DisposeBag()
    
    fahrenheitTemps.asObservable()
        .do(onNext: { $0 * $0 })
        .do(onNext: {
            print("\($0)℉ = ", terminator: "")
        })
        .map { Double($0 - 32) * 5/9.0 }
        .do(
            onError: { print($0) },
            onCompleted: { print("Completed") },
            onSubscribe: { print("Subscribed") },
            onDispose: { print("Disposed") }
        )
        .subscribe(onNext: {
            print(String(format: "%.1f℃", $0))
        })
//        .disposed(by: disposeBag)
    
    fahrenheitTemps.onNext(-40)
    
    fahrenheitTemps.onNext(0)
    
    fahrenheitTemps.onNext(32)
    
    fahrenheitTemps.onCompleted()
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
