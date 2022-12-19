//
//  FavoriteViewController.swift
//  
//
//  Created by Enrico Irawan on 19/12/22.
//
import UIKit
import Combine
import SkeletonView
import Shared
import Detail

public class FavoriteViewController: UIViewController {
    // MARK: - Properties
    var getFavoriteListUseCase: GetListFavoriteAnimeUseCase?
    private var cancellables: Set<AnyCancellable> = []
    private var animeList = [AnimeObjectEntity]()
    
    private let favoriteTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.isSkeletonable = true
        table.showsVerticalScrollIndicator = false
        table.register(AnimeTableViewCell.self, forCellReuseIdentifier: AnimeTableViewCell.identifier)
        return table
    }()
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "Empty here, try to add some :D"
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Favorite"
        view.backgroundColor = .systemBackground
        
        configureUI()
        loadFavorite()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(FAVORITE), object: nil, queue: nil) { _ in
            self.loadFavorite()
        }
    }
    
    // MARK: - Helper
    private func configureUI() {
        view.addSubview(favoriteTableView)
        favoriteTableView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.trailingAnchor,
            paddingTop: 10,
            paddingLeft: 10,
            paddingBottom: 10,
            paddingRight: 10
        )
        favoriteTableView.dataSource = self
        favoriteTableView.delegate = self
    }
    
    private func loadFavorite() {
        favoriteTableView.showSkeleton(usingColor: .silver, transition: .crossDissolve(0.25))
        getFavoriteListUseCase?.execute(request: nil)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    let alert = UIAlertController(title: "Alert", message: String(describing: completion), preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                case .finished:
                    if self.animeList.isEmpty {
                        self.favoriteTableView.backgroundView = self.emptyLabel
                        return
                    }

                    self.favoriteTableView.backgroundView = nil
                    self.favoriteTableView.hideSkeleton()
                    self.favoriteTableView.reloadData()
                }
            }, receiveValue: { animeList in
                self.animeList = animeList
            })
            .store(in: &cancellables)
    }
}

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animeList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AnimeTableViewCell.identifier, for: indexPath) as? AnimeTableViewCell else {
            return UITableViewCell()
        }
        
        let anime = animeList[indexPath.row]
        cell.configure(with: anime)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
}
