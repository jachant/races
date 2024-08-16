
import UIKit
private enum Direction {
    case left
    case right
}

class SettingsViewController: UIViewController {

    @IBOutlet weak var carImageView: UIImageView!
    private let countCarArray = Manager.shared.getCountCarArray()
    private var count = 0
    private var leftImageView = UIImageView()
    private var rightImageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.carImageView.image = UIImage(named: Manager.shared.getImageForIndex(index: count))
        self.createImagesView()
    }
    

    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        Manager.shared.saved(index: self.count)
    }
    
    @IBAction func leftButtonPressed(_ sender: UIButton) {
        self.move(direction: .left)
    }
    
    @IBAction func rightButtonPressed(_ sender: UIButton) {
        self.move(direction: .right)
    }
    
    private func move(direction: Direction) {
        switch direction {
        case .left:
            if (self.count > 0) {
                
                self.leftImageView.image = UIImage(named: Manager.shared.getImageForIndex(index: self.count))
                self.count -= 1
                self.leftImageView.frame.origin.x = self.carImageView.frame.origin.x
                UIView.animate(withDuration: 0.3) {
                    self.leftImageView.frame.origin.x = -self.carImageView.frame.width
                    self.carImageView.image = UIImage(named: Manager.shared.getImageForIndex(index: self.count))
                } completion: { _ in
                    self.leftImageView.image = nil
                }
                

            }
        case .right:
            if (self.count < (self.countCarArray - 1)) {
                self.count += 1
                self.rightImageView.image = UIImage(named: Manager.shared.getImageForIndex(index: self.count))
                
                UIView.animate(withDuration: 0.3) {
                    self.rightImageView.frame.origin.x = self.carImageView.frame.origin.x
                } completion: { _ in
                    self.carImageView.image = self.rightImageView.image
                    self.rightImageView.frame.origin.x = self.view.frame.width
                }

            }
        }
        return
    }
    
    private func createImagesView() {
        self.leftImageView.frame = CGRect(x: -self.carImageView.frame.width, y: self.carImageView.frame.origin.y, width: self.carImageView.frame.width, height: self.carImageView.frame.height)
        self.leftImageView.contentMode = .scaleAspectFill
        self.view.addSubview(self.leftImageView)
        self.rightImageView.frame = CGRect(x: self.view.frame.width, y: self.carImageView.frame.origin.y, width: self.carImageView.frame.width, height: self.carImageView.frame.height)
        self.rightImageView.contentMode = .scaleAspectFill
        self.view.addSubview(self.rightImageView)
    }
    
}
