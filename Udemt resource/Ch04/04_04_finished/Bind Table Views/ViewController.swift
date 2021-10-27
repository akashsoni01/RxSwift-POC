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

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let data = Observable.of([
        Contributor(name: "Krunoslav Zaher", gitHubID: "kzaher"),
        Contributor(name: "Yury Korolev", gitHubID: "yury"),
        Contributor(name: "Serg Dort", gitHubID: "sergdort"),
        Contributor(name: "Mo Ramezanpoor", gitHubID: "mohsenr"),
        Contributor(name: "Carlos García", gitHubID: "carlosypunto"),
        Contributor(name: "Scott Gardner", gitHubID: "scotteg"),
        Contributor(name: "Nobuo Saito", gitHubID: "tarunon"),
        Contributor(name: "Junior B.", gitHubID: "bontoJR"),
        Contributor(name: "Jesse Farless", gitHubID: "solidcell"),
        Contributor(name: "Jamie Pinkham", gitHubID: "jamiepinkham")
    ])
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data.asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: "Cell")) { (_, contributor, cell) in
                
                cell.textLabel?.text = contributor.name
                cell.detailTextLabel?.text = contributor.gitHubID
                cell.imageView?.image = contributor.image
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Contributor.self)
            .subscribe(onNext: {
                print("You selected:", $0)
            })
            .disposed(by: disposeBag)
    }
}
