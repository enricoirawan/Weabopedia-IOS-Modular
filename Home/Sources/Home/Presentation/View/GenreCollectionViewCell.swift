//
//  GenreCollectionViewCell.swift
//  
//
//  Created by Enrico Irawan on 18/12/22.
//
import UIKit
import SkeletonView

class GenreCollectionViewCell: UICollectionViewCell {
    static let identifier = "GenreCollectionViewCell"
    
    // MARK: - Properties
    let genreTitle: UILabel = {
        let label = UILabel()
        label.textColor = .systemOrange
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .systemOrange : .white
            genreTitle.textColor = isSelected ? .white : .systemOrange
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    private func configureUI() {
        backgroundColor = .white
        isSkeletonable = true
        skeletonCornerRadius = 16
        
        addSubview(genreTitle)
        genreTitle.centerX(inView: self)
        genreTitle.centerY(inView: self)
    }
    
    func configure(with genre: Genre) {
        layer.cornerRadius = 16
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemOrange.cgColor
        
        genreTitle.text = genre.name
    }
}
