import UIKit

class LocationViewController: UIViewController {
    
    @IBOutlet weak var popUp: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        addAttributesToPopUp()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.showAnimate()
    }
    
    func addAttributesToPopUp() {
        self.popUp.layer.borderWidth = 1
        self.popUp.layer.cornerRadius = 9
        self.popUp.layer.borderColor = UIColor.lightGray.cgColor
    }

    ////////////// ANIMATION /////////////
    
    private func showAnimate() {
        self.view.transform = self.view.transform.scaledBy(x: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 1.0
            self.view.transform = self.view.transform.scaledBy(x: 0.7, y: 0.7)
        })
    }
    
    private func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = self.view.transform.scaledBy(x: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion: {(finished : Bool) in
            if(finished) {
                
                self.view.removeFromSuperview()
                
            }
            
        })
    }

}
