import UIKit
import SalemoveSDK
import SwiftyBeaver

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            try Salemove.sharedInstance.configure(appToken: "")
        } catch let error {
            SwiftyBeaver.error(error.localizedDescription)
        }
    }
}

