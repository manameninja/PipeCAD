import UIKit

class CopyableLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        isUserInteractionEnabled = true
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(showMenu(_:)))
        addGestureRecognizer(longPress)
    }

    @objc private func showMenu(_ sender: UILongPressGestureRecognizer) {
        guard sender.state == .began else { return }

        becomeFirstResponder()

        let menuItem = UIMenuItem(title: "Копировать", action: #selector(customCopy(_:)))
        let menu = UIMenuController.shared
        menu.menuItems = [menuItem]

        // Показать меню в границах label'а
        if let superview = self.superview {
            menu.showMenu(from: superview, rect: self.frame)
        }
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(customCopy(_:))
    }

    @objc private func customCopy(_ sender: Any?) {
        UIPasteboard.general.string = text
        print("Скопировано: \(text ?? "")")
        
        // Опционально: скрыть меню после копирования
        if let superview = self.superview {
            UIMenuController.shared.hideMenu(from: superview)
        }
    }
}
