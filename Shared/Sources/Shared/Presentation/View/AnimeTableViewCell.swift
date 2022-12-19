//
//  AnimeTableViewCell.swift
//  
//
//  Created by Enrico Irawan on 19/12/22.
//

import UIKit
import SDWebImage
import SkeletonView

public class AnimeTableViewCell: UITableViewCell {
    public static let identifier = "AnimeTableViewCell"

    // MARK: - Properties
    private let poster: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 14
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private let title: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .black
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 2
        return label
    }()
    
    private let status: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .black
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 2
        return label
    }()
    
    private let duration: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .black
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 2
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
        stackView.distribution = .equalCentering
        stackView.alignment = .leading
        stackView.spacing = 5
        return stackView
    }()
    
    private let metaContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 5
        return stackView
    }()

    // MARK: - Life Cycle
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        isSkeletonable = true
        skeletonCornerRadius = 16
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    private func configureUI() {
        contentView.addSubview(poster)
        poster.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            paddingTop: 10,
            paddingLeft: 10,
            paddingBottom: 10,
            width: 150
        )
        
        metaContainer.addArrangedSubview(title)
        metaContainer.addArrangedSubview(status)
        metaContainer.addArrangedSubview(duration)
        scoreContainer.addArrangedSubview(scoreIcon)
        scoreContainer.addArrangedSubview(scoreDescription)
        metaContainer.addArrangedSubview(scoreContainer)
        
        contentView.addSubview(metaContainer)
        metaContainer.anchor(
            top: contentView.topAnchor,
            leading: poster.trailingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: 10,
            paddingLeft: 10,
            paddingBottom: 10,
            paddingRight: 10
        )
    }
    
    public func configure(with anime: Anime) {
        guard let url = URL(string: anime.images.jpg.imageURL) else {return}
        poster.sd_setImage(with: url, completed: nil)
        title.text = anime.title
        status.text = anime.status
        duration.text = anime.duration
        
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
    
    public func configure(with anime: AnimeObjectEntity) {
        guard let url = URL(string: anime.imageUrl) else {return}
        poster.sd_setImage(with: url, completed: nil)
        title.text = anime.title
        status.text = anime.status
        duration.text = anime.duration
        
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
