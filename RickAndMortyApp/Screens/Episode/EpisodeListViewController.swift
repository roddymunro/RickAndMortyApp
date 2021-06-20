//
//  EpisodeListViewController.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 19/06/2021.
//

import UIKit

class EpisodeListViewController: UIViewController {
    
    private var repository: EpisodeRepository!
    
    var tableView: UITableView!
    
    init(repository: EpisodeRepository) {
        super.init(nibName: nil, bundle: nil)
        self.repository = repository
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureViewController()
        repository.fetchEpisodes(onFetch: updateData)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
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
    
    private func updateData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension EpisodeListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repository.episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = EpisodeCell(style: .subtitle, reuseIdentifier: EpisodeCell.reuseId)

        cell.set(episode: repository.episodes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = repository.episodes[indexPath.item]
        
        let episodeViewController = EpisodeViewController(episode: episode, repository: repository)
        let navigationController = UINavigationController(rootViewController: episodeViewController)
        present(navigationController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY < -10 {
            repository.refresh(onFetch: updateData)
        } else if offsetY > contentHeight - height {
            guard repository.nextPageAvailable else { return }

            repository.fetchEpisodes(onFetch: updateData)
        }
    }
}
