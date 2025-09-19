import UIKit
import CoreImage
import CoreImage.CIFilterBuiltins

class ViewController: UIViewController {

    // (All IBOutlets and Properties remain the same)
    @IBOutlet weak var cameraPreviewContainerView: UIView!
    @IBOutlet weak var bottomActionContainerView: UIView!
    @IBOutlet weak var controlsContainerView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var grainOverlayImageView: UIImageView!
    @IBOutlet weak var saturationSlider: UISlider!
    @IBOutlet weak var grainSlider: UISlider!
    
    let backgroundImages = ["background2", "background3", "background4", "background5", "background6", "background7"]
    var originalImage: UIImage?
    let context = CIContext()
    private var saturationTimer: Timer?
    private let debounceInterval: TimeInterval = 0.05
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(applyTheme), name: ThemeManager.themeChangedNotification, object: nil)
        
        self.navigationController?.navigationBar.tintColor = UIColor(named: "dark_teal")
        
        // --- UI Styling ---
        cameraPreviewContainerView.layer.cornerRadius = 12.0
        cameraPreviewContainerView.clipsToBounds = true
        bottomActionContainerView.layer.cornerRadius = 12.0
        controlsContainerView.layer.cornerRadius = 12.0 // THIS LINE IS ADDED
        
        updateImage(at: 2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
    }
    
    @objc func applyTheme() {
        let theme = ThemeManager.shared.currentTheme
        
        if theme == .vibrant {
            view.backgroundColor = UIColor(named: "vibrant_background")
            controlsContainerView.backgroundColor = UIColor(named: "vibrant_yellow")
            bottomActionContainerView.backgroundColor = UIColor(named: "vibrant_blue")
        } else {
            view.backgroundColor = UIColor(named: "screen_background")
            controlsContainerView.backgroundColor = UIColor(named: "off_white")
            bottomActionContainerView.backgroundColor = UIColor(named: "bottom_controls_background")
        }
    }

    // (All other IBActions and Helper Functions remain the same)
    @IBAction func segmentDidChange(_ sender: UISegmentedControl) {
        updateImage(at: sender.selectedSegmentIndex)
    }
    
    @IBAction func saturationSliderDidChange(_ sender: UISlider) {
        saturationTimer?.invalidate()
        saturationTimer = Timer.scheduledTimer(withTimeInterval: debounceInterval, repeats: false) { [weak self] _ in
            self?.applyFilters()
        }
    }
    
    @IBAction func grainSliderDidChange(_ sender: UISlider) {
        grainOverlayImageView.alpha = CGFloat(1.0 - sender.value)
    }
    
    func updateImage(at index: Int) {
        let imageName = backgroundImages[index]
        self.originalImage = UIImage(named: imageName)
        saturationSlider.value = 0.5
        grainSlider.value = 0.0
        applyFilters()
        grainSliderDidChange(grainSlider)
    }
    
    func applyFilters() {
        guard let sourceImage = originalImage, let sourceCIImage = CIImage(image: sourceImage) else { return }
        let saturationValue = saturationSlider.value * 2
        let filter = CIFilter.colorControls()
        filter.inputImage = sourceCIImage
        filter.saturation = Float(saturationValue)
        guard let outputCIImage = filter.outputImage, let outputCGImage = context.createCGImage(outputCIImage, from: sourceCIImage.extent) else { return }
        backgroundImageView.image = UIImage(cgImage: outputCGImage)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
