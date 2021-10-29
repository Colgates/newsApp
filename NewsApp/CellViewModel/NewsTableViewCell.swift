//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Evgenii Kolgin on 27.05.2021.
//

import SDWebImage
import UIKit

class NewsTableViewCell: UITableViewCell {
    
    static let identifier = "NewsTableViewCell"
    
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let sourceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.layer.cornerRadius = 5
        label.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupConstraints() {
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(newsImageView)
        contentView.addSubview(sourceLabel)

        newsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        sourceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            newsImageView.heightAnchor.constraint(equalToConstant: 200),
            
            newsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            newsTitleLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 5),
            newsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            subtitleLabel.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: 5),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            sourceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            sourceLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 5),
            sourceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            sourceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with viewmodel: Article) {
        newsTitleLabel.text = viewmodel.title
        subtitleLabel.text = viewmodel.description
        sourceLabel.text = viewmodel.source.name
        if let url = viewmodel.urlToImage {
            newsImageView.sd_setImage(with: URL(string: url))
        }
    }
}
