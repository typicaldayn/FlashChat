import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let title = K.appName
        titleLabel.text = ""
        var charIndex = 0.0
        for char in title {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false, block: {(timer) in self.titleLabel.text?.append(char)})
            charIndex += 1
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    
    
    
}



