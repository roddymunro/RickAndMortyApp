//
//  CharacterListViewController.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-18.
//

import UIKit

class CharacterListViewController: UIViewController {

    enum Section { case main }

    private var repositories: Repositories

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Character>!
    
    init(repositories: Repositories) {
        self.repositories = repositories
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewController()
        repositories.character.fetchCharacters(onFetch: updateData)
        configureDataSource()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: CollectionViewHelper.createCharacterCollectionViewFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.reuseId)
    }

    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = NSLocalizedString(
            "navigationTitle.characters",
            comment: "The navigation title for the Characters screen."
        )
    }

    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Character>(collectionView: collectionView, cellProvider: { collectionView, indexPath, character -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.reuseId, for: indexPath) as! CharacterCell
            cell.set(character: character)
            return cell
        })
    }

    private func updateData() {
        var snapshots = NSDiffableDataSourceSnapshot<Section, Character>()
        snapshots.appendSections([.main])
        snapshots.appendItems(repositories.character.data)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshots, animatingDifferences: true)
        }
    }
}

extension CharacterListViewController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY < -10 {
            repositories.character.refresh(onFetch: updateData)
        } else if offsetY > contentHeight - height {
            guard repositories.character.nextPageAvailable else { return }
            
            repositories.character.fetchCharacters(onFetch: updateData)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = repositories.character.data[indexPath.item]
        
        let characterViewController = CharacterViewController(character: character, repositories: repositories)
        let navigationController = UINavigationController(rootViewController: characterViewController)
        present(navigationController, animated: true)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
