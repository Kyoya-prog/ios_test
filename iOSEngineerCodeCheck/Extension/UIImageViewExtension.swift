import Foundation
import class UIKit.UIImageView
import AlamofireImage

extension UIImageView {
    func setImage(url: URL) {
        af.setImage(withURL: url)
    }
}
