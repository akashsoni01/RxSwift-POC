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

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let data = [
        Contributor(name: "Krunoslav Zaher", gitHubID: "kzaher"),
        Contributor(name: "Yury Korolev", gitHubID: "yury"),
        Contributor(name: "Serg Dort", gitHubID: "sergdort"),
        Contributor(name: "Mo Ramezanpoor", gitHubID: "mohsenr"),
        Contributor(name: "Carlos García", gitHubID: "carlosypunto"),
        Contributor(name: "Scott Gardner", gitHubID: "scotteg"),
        Contributor(name: "Nobuo Saito", gitHubID: "tarunon"),
        Contributor(name: "Junior B.", gitHubID: "bontoJR"),
        Contributor(name: "Jesse Farless", gitHubID: "solidcell"),
        Contributor(name: "Jamie Pinkham", gitHubID: "jamiepinkham"),
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
    }
}

extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        else {
            return UITableViewCell()
        }
        
        let contributor = data[indexPath.row]
        cell.textLabel?.text = contributor.name
        cell.detailTextLabel?.text = contributor.gitHubID
        cell.imageView?.image = contributor.image
        return cell
    }
}

extension ViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected:", data[indexPath.row])
    }
}
