//: Please build the scheme 'RxSwiftPlayground' first

import PlaygroundSupport
import RxSwift

example(of: "Maybe") {
    
    let disposeBag = DisposeBag()
    
    enum FileWriteError: Error {
        
        case unreadable, encodingFailed
    }
    
    func write(_ text: String, toFileNamed name: String) -> Maybe<String> {
        return Maybe.create { maybe in
            let disposable = Disposables.create()
            let url = playgroundSharedDataDirectory.appendingPathComponent("\(name).txt")
            
            if let handle = FileHandle(forWritingAtPath: playgroundSharedDataDirectory.appendingPathComponent("\(name).txt").path) {
                
                guard let readData = FileManager.default.contents(atPath: url.path),
                    let contents = String(data: readData, encoding: .utf8),
                    contents.lowercased().range(of: text.lowercased()) == nil
                else {
                    maybe(.completed)
                    return disposable
                }
                
                handle.seekToEndOfFile()
                
                guard let writeData = text.data(using: .utf8) else {
                    maybe(.error(FileWriteError.encodingFailed))
                    return disposable
                }
                
                handle.write(writeData)
                maybe(.success("Success!"))
                return disposable
            } else {
                do {
                    try text.write(to: url, atomically: false, encoding: .utf8)
                    maybe(.success("Success!"))
                    return disposable
                } catch {
                    maybe(.error(error))
                    return disposable
                }
            }
        }
    }
    
    write("the misfits. ", toFileNamed: "Crazy ones")
        .subscribe { maybe in
            switch maybe {
            case .success(let element):
                print(element)
            case .completed:
                print("Completed")
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
