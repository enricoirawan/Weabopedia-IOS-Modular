//
//  AccountHeaderUIView.swift
//  
//
//  Created by Enrico Irawan on 19/12/22.
//

import UIKit

class AccountHeaderUIView: UIView {
    public static var viewHeight = CGFloat(100)

    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "enrico_photo")
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileImage)

        configureConstraint()
    }

    private func configureConstraint() {
        let profileImageConstraints = [
            profileImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 100),
            profileImage.heightAnchor.constraint(equalToConstant: AccountHeaderUIView.viewHeight)
        ]

        NSLayoutConstraint.activate(profileImageConstraints)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
