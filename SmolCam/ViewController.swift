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
    
    // --- Debouncing properties for a smooth saturation slider ---
    private var saturationTimer: Timer?
    // You can make this value smaller (e.g., 0.03) for faster updates, or larger (e.g., 0.1) for less frequent updates.
    private let debounceInterval: TimeInterval = 0.05
    
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
        // This keeps the slider UI perfectly smooth.
        // The heavy filtering work is delayed until the user pauses.
        saturationTimer?.invalidate()
        saturationTimer = Timer.scheduledTimer(withTimeInterval: debounceInterval, repeats: false) { [weak self] _ in
            self?.applyFilters()
        }
    }
    
    @IBAction func grainSliderDidChange(_ sender: UISlider) {
        // --- INVERTED GRAIN LOGIC ---
        // The slider's value is flipped.
        // At value 0.0, alpha is 1.0 (100% grain).
        // At value 1.0, alpha is 0.0 (0% grain).
        grainOverlayImageView.alpha = CGFloat(1.0 - sender.value)
    }
    
    // MARK: - Helper Functions
    
    func updateImage(at index: Int) {
        let imageName = backgroundImages[index]
        self.originalImage = UIImage(named: imageName)
        
        // --- UPDATED INITIAL VALUES ---
        saturationSlider.value = 0.5 // Default saturation (middle)
        grainSlider.value = 0.0     // Start at 0, which now means 100% grain
        
        // Apply initial settings
        applyFilters()
        grainSliderDidChange(grainSlider)
    }
    
    func applyFilters() {
        guard let sourceImage = originalImage,
              let sourceCIImage = CIImage(image: sourceImage) else { return }

        // Continuous float value for saturation
        let saturationValue = saturationSlider.value * 2
        
        let filter = CIFilter.colorControls()
        filter.inputImage = sourceCIImage
        filter.saturation = Float(saturationValue)
        
        guard let outputCIImage = filter.outputImage,
              let outputCGImage = context.createCGImage(outputCIImage, from: sourceCIImage.extent) else { return }
        
        // This is the heavy operation. By putting it here, it only runs
        // after the debounce timer fires.
        backgroundImageView.image = UIImage(cgImage: outputCGImage)
    }
}
