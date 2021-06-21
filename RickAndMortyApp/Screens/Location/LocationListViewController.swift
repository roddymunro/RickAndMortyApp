//
//  LocationListViewController.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 19/06/2021.
//

import UIKit
import SwiftUI

class LocationListViewController: UIViewController {
    
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
        tableView.register(LocationCell.self, forCellReuseIdentifier: LocationCell.reuseId)
    }

    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = NSLocalizedString(
            "navigationTitle.locations",
            comment: "The navigation title for the Locations screen."
        )
    }
    
    private func fetchData(fetchType: FetchType) {
        let fetchMethod = fetchType == .nextPage ? repositories.location.fetchLocations : repositories.location.refresh
        
        fetchMethod { result in
            switch result {
                case .success:
                    self.updateData()
                case .failure(let error):
                    self.presentErrorAlert(error: .init(title: AlertTitles.couldntFetchLocations, error: error))
            }
        }
    }
    
    private func updateData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc private func searchTapped() {
        let searchViewController = UIHostingController(
            rootView: LocationFilterView(filter: repositories.location.filter, onTrailingButtonTap: {
                self.dismiss(animated: true, completion: {
                    self.fetchData(fetchType: .refresh)
                })
            }))
        
        present(searchViewController, animated: true)
    }
}

extension LocationListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repositories.location.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LocationCell(style: .subtitle, reuseIdentifier: LocationCell.reuseId)

        cell.set(location: repositories.location.data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = repositories.location.data[indexPath.item]
        
        let locationViewController = LocationViewController(location: location, repositories: repositories)
        let navigationController = UINavigationController(rootViewController: locationViewController)
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
            guard repositories.location.nextPageAvailable else { return }
            
            fetchData(fetchType: .nextPage)
        }
    }
}
