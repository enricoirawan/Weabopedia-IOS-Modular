//
//  AnimeCollectionViewCell.swift
//  
//
//  Created by Enrico Irawan on 18/12/22.
//

import UIKit
import SDWebImage
import SkeletonView
import Shared

class AnimeCollectionViewCell: UICollectionViewCell {
    static let identifier = "AnimeCollectionViewCell"
    
    // MARK: - Properties
    private let poster: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .systemOrange
        return label
    }()
    
    private let scoreIcon: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "star.fill")
        imageView.image = image
        imageView.tintColor = .systemOrange
        return imageView
    }()
    
    private let scoreDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let scoreContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 5
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 16
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.35
        layer.shadowRadius = 2
        isSkeletonable = true
        skeletonCornerRadius = 16
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    private func configureUI() {
        addSubview(poster)
        poster.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            paddingTop: 10,
            paddingLeft: 10,
            paddingRight: 10,
            height: 200
        )
        
        addSubview(title)
        title.anchor(
            top: poster.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            paddingTop: 10,
            paddingLeft: 10,
            paddingRight: 10
        )
        
        addSubview(scoreContainer)
        scoreContainer.addArrangedSubview(scoreIcon)
        scoreContainer.addArrangedSubview(scoreDescription)
        scoreContainer.anchor(
            top: title.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            paddingTop: 10,
            paddingLeft: 10,
            paddingRight: 10
        )
    }
    
    func configure(with anime: Anime) {
        guard let url = URL(string: anime.images.jpg.imageURL) else {return}
        poster.sd_setImage(with: url, completed: nil)
        title.text = anime.title
        
        let atrributedScoreDescription = NSMutableAttributedString(string: "\(anime.score)", attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: UIColor.systemOrange
        ])
        atrributedScoreDescription.append(NSAttributedString(string: " (\(anime.scoredBy))", attributes: [
            NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .subheadline),
            NSAttributedString.Key.foregroundColor: UIColor.systemGray
        ]))
        scoreDescription.attributedText = atrributedScoreDescription
    }
}
