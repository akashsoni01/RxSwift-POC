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
import RxDataSources

struct AnimatedSectionModel {
    
    let title: String
    var data: [String]
}

extension AnimatedSectionModel: AnimatableSectionModelType {
    
    typealias Item = String
    typealias Identity = String
    
    var identity: Identity { return title }
    var items: [Item] { return data }
    
    init(original: AnimatedSectionModel, items: [String]) {
        self = original
        data = items
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addBarButtonItem: UIBarButtonItem!
    @IBOutlet var longPressGestureRecognizer: UILongPressGestureRecognizer!
    
    let disposeBag = DisposeBag()
    let dataSource = RxCollectionViewSectionedAnimatedDataSource<AnimatedSectionModel>()
    
    let data = Variable([
        AnimatedSectionModel(title: "Section: 0", data: ["0-0"])
        ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.configureCell = { _, collectionView, indexPath, title in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
            cell.titleLabel.text = title
            return cell
        }
        
        dataSource.supplementaryViewFactory = { dataSource, collectionView, kind, indexPath in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! Header
            header.titleLabel.text = dataSource.sectionModels[indexPath.section].title
            return header
        }
        
        data.asDriver()
            .drive(collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        addBarButtonItem.rx.tap
            .bind { [unowned self] in
                let section = self.data.value.count
                
                let items: [String] = {
                    var items = [String]()
                    let random = Int(arc4random_uniform(6)) + 1
                    
                    (0...random).forEach {
                        items.append("\(section)-\($0)")
                    }
                    
                    return items
                }()
                
                self.data.value += [AnimatedSectionModel(
                    title: "Section: \(section)",
                    data: items)
                ]
            }
            .disposed(by: disposeBag)
        
        longPressGestureRecognizer.rx.event
            .bind { [unowned self] in
                switch $0.state {
                case .began:
                    guard let selectedIndexPath = self.collectionView.indexPathForItem(at: $0.location(in: self.collectionView)) else { break }
                    self.collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
                case .changed:
                    self.collectionView.updateInteractiveMovementTargetPosition($0.location(in: $0.view!))
                case .ended:
                    self.collectionView.endInteractiveMovement()
                default:
                    self.collectionView.cancelInteractiveMovement()
                }
            }
            .disposed(by: disposeBag)
    }
}
