//: Please build the scheme 'RxSwiftPlayground' first

import RxSwift

example(of: "Single") {
    
    let disposeBag = DisposeBag()
    
    enum FileReadError: Error {
        
        case fileNotFound, unreadable, encodingFailed
    }
    
    func contentsOfTextFile(named name: String) -> Single<String> {
//        return Single.create { single in
//            let disposable = Disposables.create()
//
//            guard let path = Bundle.main.path(forResource: name, ofType: "txt") else {
//                single(.error(FileReadError.fileNotFound))
//                return disposable
//            }
//            
//            guard let data = FileManager.default.contents(atPath: path) else {
//                single(.error(FileReadError.unreadable))
//                return disposable
//            }
//            
//            guard let contents = String(data: data, encoding: .utf8) else {
//                single(.error(FileReadError.encodingFailed))
//                return disposable
//            }
//
//            single(.success(contents))
//            return disposable
//        }
        
        return Single.deferred {
            guard let path = Bundle.main.path(forResource: name, ofType: "txt") else {
                throw FileReadError.fileNotFound
            }
            
            guard let data = FileManager.default.contents(atPath: path) else {
                throw FileReadError.unreadable
            }
            
            guard let contents = String(data: data, encoding: .utf8) else {
                throw FileReadError.encodingFailed
            }
            
            return Single.just(contents)
        }
    }
    
    contentsOfTextFile(named: "Crazy ones")
        .subscribe {
            switch $0 {
            case .success(let string):
                print(string)
            case .error(let error):
                print(error)
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
