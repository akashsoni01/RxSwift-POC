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
    
    @IBOutlet weak var tapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldLabel: UILabel!
    @IBOutlet weak var textView: TextView!
    @IBOutlet weak var textViewLabel: UILabel!
    @IBOutlet weak var button: Button!
    @IBOutlet weak var buttonLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var segmentedControlLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var aSwitch: UISwitch!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var stepperLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var datePickerLabel: UILabel!
    
    let disposeBag = DisposeBag()
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGestureRecognizer.rx.event
//            .subscribe(onNext: { [unowned self] _ in
//                self.view.endEditing(true)
//            })
            .bind { [unowned self] _ in
                self.view.endEditing(true)
            }
            .disposed(by: disposeBag)
        
        textField.rx.text
            .bind(to: textFieldLabel.rx.text)
            .disposed(by: disposeBag)
        
        textView.rx.text.orEmpty.asDriver()
            .map {
                "Character count: \($0.characters.count)"
            }
            .drive(textViewLabel.rx.text)
            .disposed(by: disposeBag)
        
        button.rx.tap
            .bind {
                self.buttonLabel.text! += "Tapped! "
                
                self.view.endEditing(true)
                
                UIView.animate(withDuration: 0.3) {
                    self.view.layoutIfNeeded()
                }
            }
            .disposed(by: disposeBag)
        
        segmentedControl.rx.value
            .skip(1)
            .bind { [unowned self] in
                self.segmentedControlLabel.text = "Selected segment: \($0)"
                
                UIView.animate(withDuration: 0.3) {
                    self.view.layoutIfNeeded()
                }
            }
            .disposed(by: disposeBag)
        
        slider.rx.value
            .bind(to: progressView.rx.progress)
            .disposed(by: disposeBag)
        
        aSwitch.rx.value
            .map { !$0 }
            .bind(to: activityIndicator.rx.isHidden)
            .disposed(by: disposeBag)
        
        aSwitch.rx.value.asDriver()
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        stepper.rx.value
            .map { String(Int($0)) }
            .bind(to: stepperLabel.rx.text)
            .disposed(by: disposeBag)
        
        datePicker.rx.date
            .map { [unowned self] in
                "Selected date: " + self.dateFormatter.string(from: $0)
            }
            .bind(to: datePickerLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
