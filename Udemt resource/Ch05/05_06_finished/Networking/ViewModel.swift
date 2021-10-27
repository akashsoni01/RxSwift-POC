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

import RxSwift
import RxCocoa

class ViewModel {
    
    let searchText = Variable("")
    
    lazy var data: Driver<[Repository]> = {
        return self.searchText.asObservable()
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest(ViewModel.repositoriesFor)
            .asDriver(onErrorJustReturn: [])
    }()
    
    static func repositoriesFor(_ gitHubID: String) -> Observable<[Repository]> {
        guard !gitHubID.isEmpty,
            let url = URL(string: "https://api.github.com/users/\(gitHubID)/repos")
            else { return Observable.just([]) }
        
        return URLSession.shared
            .rx.json(url: url)
            .retry(3)
//            .catchErrorJustReturn([])
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .map(parse)
    }
    
    static func parse(json: Any) -> [Repository] {
        guard let items = json as? [[String: Any]] else { return [] }
        
        var repositories = [Repository]()
        
        items.forEach {
            guard let name = $0["name"] as? String,
                let url = $0["html_url"] as? String
                else { return }
            repositories.append(Repository(name: name, url: url))
        }
        
        return repositories
    }
}
