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
        
        // Set up the custom back button
        setupCustomBackButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
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

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryImageCell", for: indexPath) as! GalleryImageCell
        let imageName = allImages[indexPath.item]
        cell.imageView.image = UIImage(named: imageName)
        cell.imageView.contentMode = .scaleAspectFill
        cell.layer.cornerRadius = 12
        cell.layer.masksToBounds = true
        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 8
        let totalWidth = collectionView.bounds.width - (spacing * 3)
        let cellWidth = totalWidth / 2
        let cellHeight = cellWidth * 1.3
        return CGSize(width: cellWidth, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let spacing: CGFloat = 8
        return UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImageName = allImages[indexPath.item]
        performSegue(withIdentifier: "showImageDetail", sender: selectedImageName)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showImageDetail" {
            let destinationVC = segue.destination as! ImageViewerController
            let imageName = sender as! String
            destinationVC.imageName = imageName
        }
    }
}
