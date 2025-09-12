import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cameraPreviewContainerView: UIView!
    @IBOutlet weak var bottomActionContainerView: UIView!
    @IBOutlet weak var controlsContainerView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var grainOverlayImageView: UIImageView!
    let backgroundImages = ["background2", "background3", "background4", "background5", "background6", "background7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cameraPreviewContainerView.layer.cornerRadius = 12.0
        cameraPreviewContainerView.clipsToBounds = true
        controlsContainerView.backgroundColor = UIColor(named: "off_white")
        controlsContainerView.layer.cornerRadius = 12.0
        bottomActionContainerView.layer.cornerRadius = 12.0
    }
    @IBAction func segmentDidChange(_ sender: UISegmentedControl) {
 
            let selectedIndex = sender.selectedSegmentIndex
            let imageName = backgroundImages[selectedIndex]
            backgroundImageView.image = UIImage(named: imageName)
    }
    @IBAction func grainSliderDidChange(_ sender: UISlider) {
        let grainAlpha = CGFloat(sender.value)
                grainOverlayImageView.alpha = grainAlpha
    }
}
