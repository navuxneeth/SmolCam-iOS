import UIKit

class ImageViewerController: UIViewController {

    @IBOutlet weak var fullScreenImageView: UIImageView!
    
    var imageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let name = imageName {
            fullScreenImageView.image = UIImage(named: name)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(applyTheme), name: ThemeManager.themeChangedNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
    }
    
    @objc func applyTheme() {
        let theme = ThemeManager.shared.currentTheme
        if theme == .vibrant {
            view.backgroundColor = UIColor(named: "vibrant_background")
        } else {
            view.backgroundColor = UIColor(named: "screen_background")
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
