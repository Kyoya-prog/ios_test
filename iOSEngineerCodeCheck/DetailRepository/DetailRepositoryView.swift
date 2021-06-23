import Foundation
import UIKit

private class DetailRepositoryLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        clipsToBounds = true
        backgroundColor = UIColor(hex: "ff6600", alpha: 0.4)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.cornerRadius = 10
        clipsToBounds = true
        backgroundColor = UIColor(hex: "ff6600", alpha: 0.4)
    }

    init(isDescriptionType: Bool) {
        super.init(frame: .zero)
        if isDescriptionType {
            layer.cornerRadius = 10
            clipsToBounds = true
            backgroundColor = UIColor(hex: "ff6600", alpha: 0.4)
        } else {
            layer.cornerRadius = 10
            clipsToBounds = true
            backgroundColor = .white
        }
    }

    var padding = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)

    override func drawText(in rect: CGRect) {
        let newRect = rect.inset(by: padding)
        super.drawText(in: newRect)
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        return contentSize
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var contentSize = super.sizeThatFits(size)
        contentSize.width += padding.left + padding.right
        contentSize.height += padding.top + padding.bottom
        return contentSize
    }
}
