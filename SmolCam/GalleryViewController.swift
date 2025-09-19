import UIKit

class GalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!

    let allImages = [
        "camera_preview_background", "background2", "background3",
        "background4", "background5", "background6",
        "background7", "background8", "background9"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
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
            collectionView.backgroundColor = UIColor(named: "vibrant_background")
        } else {
            view.backgroundColor = UIColor(named: "screen_background")
            collectionView.backgroundColor = UIColor(named: "screen_background")
        }
    }
    
    // (All other collection view functions remain the same)
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return allImages.count }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryImageCell", for: indexPath) as! GalleryImageCell
        let imageName = allImages[indexPath.item]
        cell.imageView.image = UIImage(named: imageName)
        cell.imageView.contentMode = .scaleAspectFill
        cell.layer.cornerRadius = 12
        cell.layer.masksToBounds = true
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 8
        let totalWidth = collectionView.bounds.width - (spacing * 3)
        let cellWidth = totalWidth / 2
        let cellHeight = cellWidth * 1.3
        return CGSize(width: cellWidth, height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets { return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8) }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { return 8 }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { return 8 }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImageName = allImages[indexPath.item]
        performSegue(withIdentifier: "showImageDetail", sender: selectedImageName)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showImageDetail" {
            let destinationVC = segue.destination as! ImageViewerController
            let imageName = sender as! String
            destinationVC.imageName = imageName
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
