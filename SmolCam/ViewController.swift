import UIKit
import CoreImage
import CoreImage.CIFilterBuiltins

class ViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var cameraPreviewContainerView: UIView!
    @IBOutlet weak var bottomActionContainerView: UIView!
    @IBOutlet weak var controlsContainerView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var grainOverlayImageView: UIImageView!
    @IBOutlet weak var saturationSlider: UISlider!
    @IBOutlet weak var grainSlider: UISlider!
    
    // MARK: - Properties
    let backgroundImages = ["background2", "background3", "background4", "background5", "background6", "background7"]
    var originalImage: UIImage?
    let context = CIContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // --- UI Styling ---
        cameraPreviewContainerView.layer.cornerRadius = 12.0
        cameraPreviewContainerView.clipsToBounds = true
        bottomActionContainerView.layer.cornerRadius = 12.0
        controlsContainerView.backgroundColor = UIColor(named: "off_white")
        controlsContainerView.layer.cornerRadius = 12.0
        
        // --- Initial Setup ---
        updateImage(at: 2)
    }

    // MARK: - IBActions
    @IBAction func segmentDidChange(_ sender: UISegmentedControl) {
        updateImage(at: sender.selectedSegmentIndex)
    }
    
    @IBAction func saturationSliderDidChange(_ sender: UISlider) {
        applyFilters()
    }
    
    @IBAction func grainSliderDidChange(_ sender: UISlider) {
        grainOverlayImageView.alpha = CGFloat(sender.value)
    }
    
    // MARK: - Helper Functions
    
    func updateImage(at index: Int) {
        let imageName = backgroundImages[index]
        self.originalImage = UIImage(named: imageName)
        
        saturationSlider.value = 0.5
        grainSlider.value = 0.0
        
        applyFilters()
        grainSliderDidChange(grainSlider)
    }
    
    func applyFilters() {
        // The value from the slider (0.0 to 1.0) is mapped to a saturation value.
        // We'll use a range of 0 (grayscale) to 2 (super saturated).
        let saturationValue = saturationSlider.value * 2
        
        guard let sourceImage = originalImage,
              let sourceCIImage = CIImage(image: sourceImage) else { return }

        // Apply the saturation filter
        let filter = CIFilter.colorControls()
        filter.inputImage = sourceCIImage
        filter.saturation = Float(saturationValue)
        
        // --- THIS IS THE FIX ---
        // We must first render the output CIImage into a CGImage.
        guard let outputCIImage = filter.outputImage,
              let outputCGImage = context.createCGImage(outputCIImage, from: sourceCIImage.extent) else { return }
        
        // Now we can safely create a UIImage from the CGImage.
        backgroundImageView.image = UIImage(cgImage: outputCGImage)
    }
}
