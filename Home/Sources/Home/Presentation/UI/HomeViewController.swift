//
//  HomeViewController.swift
//  
//
//  Created by Enrico Irawan on 18/12/22.
//

import UIKit
import Combine
import SkeletonView
import Shared
import Detail

public class HomeViewController: UIViewController {
    // MARK: - Properties
    var getAnimeUseCase: GetAnimeUseCase?
    var getGenreUseCase: GetGenreUseCase?
    private var cancellables: Set<AnyCancellable> = []
    private var genreList: [Genre]?
    private var animeList: [Anime]?
    private var selectedGenreId: Int?
    
    private let appTitle: UILabel = {
        let label = UILabel()
        let atrributedTitle = NSMutableAttributedString(string: "Weabo", attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 40),
            NSAttributedString.Key.foregroundColor: UIColor.systemOrange
        ])
        atrributedTitle.append(NSAttributedString(string: "pedia", attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 40),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]))
        label.attributedText = atrributedTitle
        return label
    }()
    
    private let genreCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isSkeletonable = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: GenreCollectionViewCell.identifier)
        return collectionView
    }()
    
    private let animeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isSkeletonable = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(AnimeCollectionViewCell.self, forCellWithReuseIdentifier: AnimeCollectionViewCell.identifier)
        return collectionView
    }()
    
    private let refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.attributedTitle = NSAttributedString(string: "pull to refresh")
        return rc
    }()
    
    // MARK: - Life Cycle
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureUI()
        loadGenre()
    }
    
    // MARK: - Selector
    @objc func refresh() {
        guard let selectedGenreId = selectedGenreId else {return}
        loadAnime(withGenreId: selectedGenreId)
    }
    
    // MARK: - Helper
    private func configureUI() {
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(appTitle)
        appTitle.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            paddingTop: 16,
            paddingLeft: 10
        )
        
        view.addSubview(genreCollectionView)
        genreCollectionView.dataSource = self
        genreCollectionView.delegate = self
        genreCollectionView.anchor(
            top: appTitle.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            paddingTop: 10,
            height: 50
        )
        
        view.addSubview(animeCollectionView)
        animeCollectionView.dataSource = self
        animeCollectionView.delegate = self
        animeCollectionView.anchor(
            top: genreCollectionView.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            paddingTop: 10
        )
        animeCollectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    private func loadGenre() {
        genreCollectionView.showSkeleton(usingColor: .silver, transition: .crossDissolve(0.25))
        getGenreUseCase?.execute(request: nil)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    let alert = UIAlertController(title: "Alert", message: String(describing: completion), preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                case .finished:
                    self.genreCollectionView.hideSkeleton(reloadDataAfter: true)
                    
                    // pre-select when collection views appear
                    let preSelectIndex = IndexPath(item: 0, section: 0)
                    self.genreCollectionView.selectItem(at: preSelectIndex, animated: false, scrollPosition: [])
                    let cell = self.genreCollectionView.cellForItem(at: preSelectIndex)
                    cell?.isSelected = true
                    
                    guard let genreList = self.genreList else {return}
                    let selectedGenreId = genreList[preSelectIndex.item].id
                    self.loadAnime(withGenreId: selectedGenreId)
                }
            }, receiveValue: { [weak self] genreList in
                self?.genreList = genreList
            })
            .store(in: &cancellables)
    }
    
    private func loadAnime(withGenreId genreId: Int) {
        animeCollectionView.showSkeleton(usingColor: .silver, transition: .crossDissolve(0.25))
        getAnimeUseCase?.execute(request: genreId)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    let alert = UIAlertController(title: "Alert", message: String(describing: completion), preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                case .finished:
                    self.refreshControl.endRefreshing()
                    self.animeCollectionView.hideSkeleton(reloadDataAfter: true)
                }
            }, receiveValue: { [weak self] animeList in
                self?.animeList = animeList
            })
            .store(in: &cancellables)
    }
}

extension HomeViewController: SkeletonCollectionViewDataSource, SkeletonCollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // MARK: - SkeletonCollectionViewDataSource
    public func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        if skeletonView == self.genreCollectionView {
            return GenreCollectionViewCell.identifier
        }
        
        return AnimeCollectionViewCell.identifier
    }
    
    public func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    // MARK: - UICollectionViewDataSource
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.genreCollectionView {
            guard let genres = genreList else { return 0 }
            return genres.count
        }
        
        guard let animeList = animeList else { return 0 }
        return animeList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.genreCollectionView {
            guard let genreCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: GenreCollectionViewCell.identifier,
                for: indexPath
            ) as? GenreCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            guard let genreList = genreList else { return UICollectionViewCell() }
            let genre = genreList[indexPath.row]
            genreCell.configure(with: genre)
            
            return genreCell
        }
        
        guard let animeCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AnimeCollectionViewCell.identifier,
            for: indexPath
        ) as? AnimeCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let animeList = animeList else { return UICollectionViewCell() }
        let anime = animeList[indexPath.row]
        animeCell.configure(with: anime)
        
        return animeCell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.genreCollectionView {
            guard let genreList = genreList else { return }
            let selectedGenre = genreList[indexPath.row]
            self.selectedGenreId = selectedGenre.id
            loadAnime(withGenreId: selectedGenre.id)
            return
        }
        
        guard let animeList = animeList else {return}
        let selectedAnimeId = animeList[indexPath.row].id
        
        let detailVC = DetailModule().container.resolve(DetailViewController.self)
        guard let detailVC = detailVC else { return }
        detailVC.configure(withAnimeId: selectedAnimeId)
        
        let nav = UINavigationController(rootViewController: detailVC)
        nav.modalPresentationStyle = .fullScreen
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemOrange
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance
        nav.navigationBar.tintColor = .white
        present(nav, animated: true)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.genreCollectionView {
            return CGSize(width: 150, height: 50)
        }
        
        return CGSize(width: view.frame.width / 2 - 15, height: 280)
    }
}
