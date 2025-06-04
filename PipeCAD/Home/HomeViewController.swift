//
//  ViewController.swift
//  PipeInfo
//
//  Created by Даниил Павленко on 22.04.2025.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var homeTableView: UITableView!
    
    // Данные для таблицы: массив с иконками, заголовками и значениями
    private let items: [(icon: String, title: String)] = [
        (icon: "circle.dotted.circle", title: "Переходы"),
        (icon: "rainbow", title: "Тройники"),
        (icon: "circlebadge", title: "Прокладки"),
        (icon: "pipe.and.drop", title: "Клапаны"),
        (icon: "circle.grid.2x1.right.filled", title: "Линейные заготовки"),
        (icon: "circle", title: "Трубы"),
        (icon: "chart.line.uptrend.xyaxis", title: "Улучшить"),
        (icon: "gear", title: "Настройки"),
        (icon: "info.bubble", title: "Справка"),
    ]
    
    override func viewDidLoad() {
        for family in UIFont.familyNames {
            print("Family: \(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print(" - \(name)")
            }
        }
        
        super.viewDidLoad()
        self.title = "Главное меню"
        setupTableView()
    }
    
    private func setupTableView() {
        homeTableView.delegate = self
        homeTableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let cellHeight = homeTableView.frame.height / 9 - 16
        HomeTableViewCell.cellHeight = cellHeight
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeTableViewCell
        
        let item = items[indexPath.row]
        cell.iconImageView.image = UIImage(systemName: item.icon)
        cell.titleLabel.text = item.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let sBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = sBoard.instantiateViewController(withIdentifier: "MainVC") as! TransitionViewController
            self.navigationItem.backButtonTitle = ""
            vc.screenTitle = items[indexPath.row].title
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let sBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = sBoard.instantiateViewController(withIdentifier: "TeeVC") as! TeeViewController
            self.navigationItem.backButtonTitle = ""
            vc.screenTitle = items[indexPath.row].title
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}
