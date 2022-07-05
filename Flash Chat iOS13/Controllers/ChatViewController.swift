import Firebase
import UIKit

class ChatViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.hidesBackButton = true
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        loadMessages()
    }
    //Loading messages from Firebase
    func loadMessages() {
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)//sort by date
        //updates when changes
            .addSnapshotListener(){ querySnapshot, error in
                self.messages = []
                if let e = error {
                    print(e.localizedDescription)
                }else{
                    if let snapShotDocuments = querySnapshot?.documents {
                        for doc in snapShotDocuments {
                            let data = (doc.data())
                            if let sender = data[K.FStore.senderField] as? String, let body = data[K.FStore.bodyField] as? String {
                                //configuring messages
                                let message: Message = (Message(body: body, sender: sender))
                                self.messages.append(message)
                                //Updating tableview on main thread
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                    let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                                }
                                
                            }
                        }
                    }
                }
            }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email{
            //get user info and sending to firebase storage
            //cofiguring collection in Firebase
            db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField: messageSender, K.FStore.bodyField: messageBody, K.FStore.dateField: Date().timeIntervalSince1970]) { (error) in
                if let e = error {
                    print("There was an issue retrieving data to FStore, \(e)")
                }else{
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                }
            }
        }
    }
    
    @IBAction func logOutpressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: true)
        //returning to first VC
    }
    
}
//MARK: - Extensions
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        //configuring reusable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.messageText.text = message.body
        
        //Message from the current user
        
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.bubbleMessage.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.messageText.textColor = UIColor(named: K.BrandColors.purple)
        }else{
            
            //Message from another sender
            
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.bubbleMessage.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.messageText.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        return cell
    }
}
