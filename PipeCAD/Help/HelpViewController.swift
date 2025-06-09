//
//  HelpViewController.swift
//  PipeCAD
//
//  Created by Даниил Павленко on 07.06.2025.
//

import UIKit

class HelpViewController: UIViewController {
    
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var tgAuthorButton: UIButton!
    @IBOutlet weak var tgDeveloperButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        setupNavigationBar()
        emailButton.addTarget(self, action: #selector(sendEmail), for: .touchUpInside)
        tgAuthorButton.addTarget(self, action: #selector(openTelegramAuthor), for: .touchUpInside)
        tgDeveloperButton.addTarget(self, action: #selector(openTelegramDeveloper), for: .touchUpInside)
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = "Справка"
    }
    
    @objc func openTelegramAuthor() {
        if let url = URL(string: "https://t.me/gasan_artur"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            // Можно показать алерт, если Telegram не установлен
            let alert = UIAlertController(title: "Ошибка", message: "Не удалось открыть Telegram", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    
    @objc func openTelegramDeveloper() {
        if let url = URL(string: "https://t.me/manameninja"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            // Можно показать алерт, если Telegram не установлен
            let alert = UIAlertController(title: "Ошибка", message: "Не удалось открыть Telegram", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    
    @objc func sendEmail() {
        let email = "gasan-artur94@yandex.ru"
        if let url = URL(string: "mailto:\(email)"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            // Можно показать алерт, если Telegram не установлен
            let alert = UIAlertController(title: "Ошибка", message: "Не удалось открыть почтовый ящик. Попробуйте написать на электронную почту \(email) самостоятельно.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
}
