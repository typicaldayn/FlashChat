import Firebase
import UIKit

class RegisterViewController: UIViewController {
    
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
    
    @IBAction func registerPressed(_ sender: UIButton) {
        //check password to be at least 6 char
        //check mail to be proper
        //performing next vc
        if let password = passwordTextfield.text, let email = emailTextfield.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error{
                    print(error.localizedDescription)
            }else {
                self.performSegue(withIdentifier: K.registerSegue, sender: self)
            }
            }
        }
    }
}

