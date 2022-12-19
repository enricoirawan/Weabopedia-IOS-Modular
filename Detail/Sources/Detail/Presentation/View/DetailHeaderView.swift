//
//  DetailHeaderView.swift
//  
//
//  Created by Enrico Irawan on 18/12/22.
//

import UIKit
import SDWebImage
import Shared

protocol DetailHeaderViewDelegate: AnyObject {
    func favoriteButtonTapped()
}

class DetailHeaderView: UICollectionReusableView {
    static let identifier = "DetailHeaderView"
    
    // MARK: - Properties
    public var delegate: DetailHeaderViewDelegate?
    private var anime: Anime?
    
    private let poster: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.numberOfLines = 2
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let titleEnglish: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 2
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let scoreIcon: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "star.fill")
        imageView.image = image
        imageView.tintColor = .systemYellow
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
        return stackView
    }()

    private let metaContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        return stackView
    }()
    
    private let infoContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .leading
        return stackView
    }()
    
    private let rating: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 2
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let status: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 1
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setTitle("Add to favorite", for: .normal)
        button.tintColor = .systemOrange
        button.backgroundColor = .white
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(favoriteHandler), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemOrange
        configureUI()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleToogle),
            name: Notification.Name(TOGGLE_FAVORITE),
            object: nil
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selector
    @objc private func favoriteHandler() {
        delegate?.favoriteButtonTapped()
    }
    
    @objc private func handleToogle(_ notification: NSNotification) {
        if let dict = notification.userInfo as NSDictionary? {
            if let isFavorite = dict["isFavorite"] as? Bool {
                if isFavorite {
                    favoriteButton.setTitle("Marked as favorite", for: .normal)
                    favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                } else {
                    favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
                    favoriteButton.setTitle("Add to favorite", for: .normal)
                }
            }
        }
    }
    
    // MARK: - Helper
    private func configureUI() {
        addSubview(poster)
        poster.anchor(
            top: safeAreaLayoutGuide.topAnchor,
            leading: leadingAnchor,
            paddingTop: 20,
            paddingLeft: 10,
            width: 150,
            height: 210
        )
        
        addSubview(infoContainer)
        scoreContainer.addArrangedSubview(scoreIcon)
        scoreContainer.addArrangedSubview(scoreDescription)

        metaContainer.addArrangedSubview(title)
        metaContainer.addArrangedSubview(titleEnglish)
        
        metaContainer.addArrangedSubview(rating)
        metaContainer.addArrangedSubview(status)
        metaContainer.addArrangedSubview(scoreContainer)
        
        infoContainer.addArrangedSubview(metaContainer)
        
        infoContainer.addArrangedSubview(favoriteButton)
        favoriteButton.setDimensions(width: 200, height: 40)
        infoContainer.anchor(
            top: safeAreaLayoutGuide.topAnchor,
            leading: poster.trailingAnchor,
            trailing: trailingAnchor,
            paddingTop: 20,
            paddingLeft: 10,
            paddingRight: 10,
            height: 210
        )
    }
    
    func configure(with anime: Anime) {
        self.anime = anime
        guard let url = URL(string: anime.images.jpg.imageURL) else {return}
        poster.sd_setImage(with: url, completed: nil)
        
        title.text = "(\(anime.type)) \(anime.title)"
        titleEnglish.text = "English: (\(anime.titleEnglish))"
        status.text = anime.status
        rating.text = anime.rating
        
        let atrributedScoreDescription = NSMutableAttributedString(string: "\(anime.score)", attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ])
        atrributedScoreDescription.append(NSAttributedString(string: " (\(anime.scoredBy) votes)", attributes: [
            NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .subheadline),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]))
        scoreDescription.attributedText = atrributedScoreDescription
    }
}
