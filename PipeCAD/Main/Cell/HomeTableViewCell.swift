//
//  TableViewCell.swift
//  PipeInfo
//
//  Created by Даниил Павленко on 22.04.2025.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    static var cellHeight: CGFloat = 60
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupImageView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func setupImageView() {
        // Отступы (16pt с каждой стороны)
        let imageSize = HomeTableViewCell.cellHeight
        iconImageView.clipsToBounds = true
        print(HomeTableViewCell.cellHeight)
        // Обновляем констрейнты
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: imageSize),
            iconImageView.heightAnchor.constraint(equalToConstant: imageSize)
        ])
    }
    
}
