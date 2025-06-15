//
//  Extension+View.swift
//  PipeInfo
//
//  Created by Даниил Павленко on 28.04.2025.
//

import UIKit
import Photos

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { context in
            layer.render(in: context.cgContext)
        }
    }
}

extension UIFont {
    static func customFont(name: String, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: name, size: size) else {
            print("Шрифт \(name) не найден! Используется системный.")
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
}

// MARK: - SAVE PHOTOS

extension UIViewController {
    func saveImageToPhotosAlbum(_ image: UIImage, in viewController: UIViewController) {
        let status = PHPhotoLibrary.authorizationStatus(for: .addOnly) // Только на запись
        switch status {
        case .authorized, .limited:
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            showAccesPhotoAlert(in: viewController)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(for: .addOnly) { newStatus in
                DispatchQueue.main.async {
                    if newStatus == .authorized || newStatus == .limited {
                        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                    } else {
                        self.showPermissionAlert(in: viewController)
                    }
                }
            }
        default:
            showPermissionAlert(in: viewController)
        }
    }
    private func showAccesPhotoAlert(in viewController: UIViewController) {
        let alert = UIAlertController(
            title: "Изображение сохранено",
            message: "Изображение успешно сохранено в галлерею",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "ОК", style: .default))
        viewController.present(alert, animated: true)
    }
    
    private func showPermissionAlert(in viewController: UIViewController) {
        let alert = UIAlertController(
            title: "Нет доступа к Фото",
            message: "Разрешите сохранение в Настройках → Конфиденциальность → Фото.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Открыть настройки", style: .default) { _ in
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings)
            }
        })
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        viewController.present(alert, animated: true)
    }
}

extension String {
    var toDouble: Double {
        Double(self.replacingOccurrences(of: ",", with: ".")) ?? 0.0
    }
}
