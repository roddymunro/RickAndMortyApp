//
//  EpisodeListViewController.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 19/06/2021.
//

import UIKit
import SwiftUI

class EpisodeListViewController: UIViewController {
    
    private var repositories: Repositories
    
    var tableView: UITableView!
    
    init(repositories: Repositories) {
        self.repositories = repositories
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureViewController()
        fetchData(fetchType: .nextPage)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTapped))
    }

    private func configureTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemBackground
        tableView.register(EpisodeCell.self, forCellReuseIdentifier: EpisodeCell.reuseId)
    }

    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = NSLocalizedString(
            "navigationTitle.episodes",
            comment: "The navigation title for the Episodes screen."
        )
    }
    
    private func fetchData(fetchType: FetchType) {
        let fetchMethod = fetchType == .nextPage ? repositories.episode.fetchNextPage : repositories.episode.refresh
        
        fetchMethod { result in
            switch result {
                case .success:
                    self.updateData()
                case .failure(let error):
                    self.presentErrorAlert(error: .init(title: AlertTitles.couldntFetchEpisode, error: error))
            }
        }
    }
    
    private func updateData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc private func searchTapped() {
        if let filter = repositories.episode.filter as? EpisodeFilter {
            let searchViewController = UIHostingController(
                rootView: EpisodeFilterView(filter: filter, onTrailingButtonTap: {
                    self.dismiss(animated: true, completion: {
                        self.fetchData(fetchType: .refresh)
                    })
                }))
            
            present(searchViewController, animated: true)
        }
    }
}

extension EpisodeListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repositories.episode.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = EpisodeCell(style: .subtitle, reuseIdentifier: EpisodeCell.reuseId)

        cell.set(episode: repositories.episode.data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = repositories.episode.data[indexPath.item]
        
        let episodeViewController = EpisodeViewController(episode: episode, repositories: repositories)
        let navigationController = UINavigationController(rootViewController: episodeViewController)
        present(navigationController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY < -10 {
            fetchData(fetchType: .refresh)
        } else if offsetY > contentHeight - height {
            guard repositories.episode.nextPageAvailable else { return }

            fetchData(fetchType: .nextPage)
        }
    }
}
