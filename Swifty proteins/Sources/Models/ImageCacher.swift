import UIKit

class ImageCacher {
	public static func cache(image: UIImage, as name: String) -> URL? {
		guard let imageData = image.pngData() else {
			return nil
		}
		
		do {
			let imageURL = getPathToImage(imageName: name + ".png")
			
			try imageData.write(to: imageURL)
			return imageURL
		} catch {
			return nil
		}
	}
	
	private static func getPathToImage(imageName: String) -> URL {
		return FileManager.default
			.urls(for: .cachesDirectory, in: .userDomainMask)
			.first!
			.appendingPathComponent(imageName)
	}
}
