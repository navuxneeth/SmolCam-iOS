import UIKit
import SafariServices

class SettingsViewController: UIViewController {

    @IBOutlet weak var themeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var storageImageView: UIImageView!
    @IBOutlet weak var creditsTextView: UITextView!
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var repositoryButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(applyTheme), name: ThemeManager.themeChangedNotification, object: nil)
        
        configureInitialState()
        
        contactButton.layer.cornerRadius = 12
        repositoryButton.layer.cornerRadius = 12
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
    }

    func configureInitialState() {
        let currentTheme = ThemeManager.shared.currentTheme
        themeSegmentedControl.selectedSegmentIndex = (currentTheme == .original) ? 0 : 1
    }

    @objc func applyTheme() {
        let theme = ThemeManager.shared.currentTheme
        setupCreditsLink()
        
        if theme == .vibrant {
            view.backgroundColor = UIColor(named: "vibrant_background")
            storageImageView.image = UIImage(named: "storage_info_vibranttheme")
            creditsTextView.backgroundColor = UIColor(named: "vibrant_background")
            creditsTextView.textColor = .black
            themeSegmentedControl.backgroundColor = UIColor(named: "vibrant_yellow")
            themeSegmentedControl.selectedSegmentTintColor = UIColor(named: "vibrant_blue")
            contactButton.backgroundColor = UIColor(named: "vibrant_blue")
            repositoryButton.backgroundColor = UIColor(named: "vibrant_blue")

            // Request 1 & 2: Set text colors for Vibrant theme
            let vibrantTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            themeSegmentedControl.setTitleTextAttributes(vibrantTextAttributes, for: .normal)
            contactButton.setTitleColor(.white, for: .normal)
            repositoryButton.setTitleColor(.white, for: .normal)
            
        } else { // Original Theme
            view.backgroundColor = UIColor(named: "screen_background")
            storageImageView.image = UIImage(named: "storage_info_originaltheme")
            creditsTextView.backgroundColor = UIColor(named: "screen_background")
            creditsTextView.textColor = UIColor(named: "dark_teal")
            themeSegmentedControl.backgroundColor = UIColor(named: "accent_red")
            themeSegmentedControl.selectedSegmentTintColor = UIColor(named: "dark_teal")
            contactButton.backgroundColor = UIColor(named: "dark_teal")
            repositoryButton.backgroundColor = UIColor(named: "dark_teal")

            // Request 1 & 2: Set text colors for Original theme
            let originalTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "screen_background")!]
            themeSegmentedControl.setTitleTextAttributes(originalTextAttributes, for: .normal)
            contactButton.setTitleColor(UIColor(named: "screen_background"), for: .normal)
            repositoryButton.setTitleColor(UIColor(named: "screen_background"), for: .normal)
        }
    }

    func setupCreditsLink() {
        let theme = ThemeManager.shared.currentTheme
        let fullText = "Designed by Navaneeth\nMentored by Prof. Chesta Malkani\nInspired by HaHo Design System by Hristov\n \n Copyright © Navaneeth :) Sep 2025"
        let linkText = "Prof. Chesta Malkani"
        let linkColor = (theme == .vibrant) ? UIColor(named: "vibrant_blue")! : UIColor(named: "dark_teal")!
        
        let attributedString = NSMutableAttributedString(string: fullText)
        let linkRange = (fullText as NSString).range(of: linkText)
        
        let linkAttributes: [NSAttributedString.Key: Any] = [
            .link: URL(string: "https://in.linkedin.com/in/chesta-malkani-25a550137")!,
            .foregroundColor: linkColor,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        attributedString.addAttributes(linkAttributes, range: linkRange)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 4
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: fullText.count))
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 14), range: NSRange(location: 0, length: fullText.count))

        creditsTextView.attributedText = attributedString
    }

    @IBAction func themeChanged(_ sender: UISegmentedControl) {
        ThemeManager.shared.currentTheme = (sender.selectedSegmentIndex == 0) ? .original : .vibrant
    }
    
    @IBAction func contactButtonTapped(_ sender: UIButton) {
        if let url = URL(string: "https://www.linkedin.com/in/navaneeth-sankar-k-p") {
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true)
        }
    }
    
    @IBAction func repositoryButtonTapped(_ sender: UIButton) {
        if let url = URL(string: "https://github.com/navuxneeth/smolcam-ios") {
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
