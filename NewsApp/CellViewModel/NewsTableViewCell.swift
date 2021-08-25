//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Evgenii Kolgin on 27.05.2021.
//

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
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(newsImageView)
        contentView.addSubview(sourceLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10))
        
        
        newsImageView.frame = CGRect(x: 10,
                                     y: 0,
                                     width: contentView.frame.size.width - 20,
                                     height: 160)
        newsTitleLabel.frame = CGRect(x: 10,
                                      y: 165,
                                      width: contentView.frame.size.width - 20,
                                      height: 40)
        subtitleLabel.frame = CGRect(x: 10,
                                     y: 205,
                                     width: contentView.frame.size.width - 20,
                                     height: 40)
        sourceLabel.frame = CGRect(x: 10,
                                   y: 245,
                                   width: contentView.frame.size.width - 20,
                                   height: 40)
    }
    
    func configure(with viewmodel: Article) {
        newsTitleLabel.text = viewmodel.title
        subtitleLabel.text = viewmodel.description
        sourceLabel.text = viewmodel.source.name
        
        
        if let url = viewmodel.urlToImage {
            guard let url = URL(string: url) else { return }
            
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else { return }

                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
            }
            .resume()
        }
    }
}
