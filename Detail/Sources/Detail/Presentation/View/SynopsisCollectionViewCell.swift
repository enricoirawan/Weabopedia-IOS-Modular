//
//  SynopsisCollectionViewCell.swift
//  
//
//  Created by Enrico Irawan on 18/12/22.
//

import UIKit

class SynopsisCollectionViewCell: UICollectionViewCell {
    static let identifier = "SynopsisCollectionViewCell"
    
    // MARK: - Properties
    private let sectionTitle: UILabel = {
        let label = UILabel()
        label.text = "Synopsis"
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        return label
    }()
    
    private let synopsis: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selector
    
    // MARK: - Helper
    private func configureUI() {
        addSubview(sectionTitle)
        sectionTitle.anchor(
            top: safeAreaLayoutGuide.topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            paddingTop: 10,
            paddingLeft: 10
        )
        
        addSubview(synopsis)
        synopsis.anchor(
            top: sectionTitle.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            paddingTop: 10,
            paddingLeft: 10
        )
    }
    
    func configure(with synopsisText: String) {
        synopsis.text = synopsisText
    }
}
