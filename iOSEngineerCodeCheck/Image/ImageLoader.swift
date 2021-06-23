import Foundation
import UIKit

class ImageLoader {
    init(imageURL: URL) {
        self.imageURL = imageURL
    }

    let imageURL: URL

    func load(completion: @escaping (Result<UIImage, Error>) -> Void) {
        URLSession.shared.dataTask(with: imageURL) { data, _, err in
            if let error = err {
                completion(.failure(error))
            }
            if let data = data, let image = UIImage(data: data) {
                completion(.success(image))
            }
        }
        // taskを開始する
        .resume()
    }
}
