//
//  LocationListViewController.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 19/06/2021.
//

import UIKit

class LocationListViewController: UIViewController {
    
    private var repository: LocationRepository!
    
    var tableView: UITableView!
    
    init(repository: LocationRepository) {
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
        repository.fetchLocations(onFetch: updateData)
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
    
    private func updateData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension LocationListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repository.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LocationCell(style: .subtitle, reuseIdentifier: LocationCell.reuseId)

        cell.set(location: repository.locations[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = repository.locations[indexPath.item]
        
        let locationViewController = LocationViewController(location: location, repository: repository)
        let navigationController = UINavigationController(rootViewController: locationViewController)
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

            repository.fetchLocations(onFetch: updateData)
        }
    }
}
