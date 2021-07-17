import SwiftUI

struct ImageSharingViewController: UIViewControllerRepresentable {
    public var image: UIImage
	public var title: String
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
		let controller = UIActivityViewController(activityItems: [cacheImage()], applicationActivities: nil)
        return controller
    }

	private func cacheImage() -> URL {
		return ImageCacher.cache(image: image, as: title)!
	}
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
    }
}
