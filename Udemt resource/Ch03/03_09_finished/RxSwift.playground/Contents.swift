//: Please build the scheme 'RxSwiftPlayground' first

import PlaygroundSupport
import RxSwift

example(of: "Completable") {
    
    let disposeBag = DisposeBag()
    
    func write(_ text: String, toFileNamed name: String) -> Completable {
        return Completable.create { completable in
            let disposable = Disposables.create()
            let url = playgroundSharedDataDirectory.appendingPathComponent("\(name).txt")
            
            do {
                try text.write(to: url, atomically: false, encoding: .utf8)
                completable(.completed)
                return disposable
            } catch {
                completable(.error(error))
                return disposable
            }
        }
    }
    
    write("Here's to the crazy ones.", toFileNamed: "Crazy ones")
        .subscribe { completable in
            switch completable {
            case .completed:
                print("Success!")
            case .error(let error):
                print("Failed:", error)
            }
        }
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
