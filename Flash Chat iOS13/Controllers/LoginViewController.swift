import Foundation
import Firebase
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
        }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = UIColor(named: K.BrandColors.blue)
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        //check if password and mail are existing and performing next VC
        if let password = passwordTextfield.text, let email = emailTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                if let e = error{
                    print(e.localizedDescription)
                }else {
                    self!.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
            }
        }
    }
}
