import UIKit

class ImageViewerController: UIViewController {

    @IBOutlet weak var fullScreenImageView: UIImageView!
    
    // This variable will be set by the GalleryViewController before this screen appears
    var imageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Check if an imageName was passed from the gallery
        if let name = imageName {
            // If it exists, set it as the image for our image view
            fullScreenImageView.image = UIImage(named: name)
        }
        
        // Set up the custom back button
        setupCustomBackButton()
    }
    
    // MARK: - Custom Back Button
    
    func setupCustomBackButton() {
        self.navigationItem.hidesBackButton = true // Hide the default back button
        let customBackButton = UIBarButtonItem(image: UIImage(named: "arrowbutton"), style: .plain, target: self, action: #selector(backButtonTapped))
        customBackButton.tintColor = UIColor(named: "bottom_controls_background") // Set the arrow color
        self.navigationItem.leftBarButtonItem = customBackButton
    }

    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true) // Go back to the previous screen
    }
}
