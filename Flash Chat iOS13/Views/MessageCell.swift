import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var bubbleMessage: UIView!
    @IBOutlet weak var messageText: UILabel!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bubbleMessage.layer.cornerRadius = bubbleMessage.frame.height / 5
    }

}
