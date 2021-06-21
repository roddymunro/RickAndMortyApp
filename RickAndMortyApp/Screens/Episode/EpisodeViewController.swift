//
//  EpisodeViewController.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 19/06/2021.
//

import UIKit

class EpisodeViewController: UIViewController {
    
    private var episode: Episode!
    
    private var repositories: Repositories
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let detailsCard = CardView()
    let detailsHeaderLabel = TitleLabel(textAlignment: .left)
    let nameDetail = DetailView(title: NSLocalizedString(
        "label.episode.name", comment: "The label for the episode's name detail."))
    let airDateDetail = DetailView(title: NSLocalizedString(
        "label.episode.airDate", comment: "The label for the episode's air date detail."))
    let episodeDetail = DetailView(title: NSLocalizedString(
        "label.episode.episode", comment: "The label for the episode's episode key detail."))
    
    let charactersCard = CardView()
    let charactersHeaderLabel = TitleLabel(textAlignment: .left)
    var characterButtons: [OpenButton] = []
    
    var closeButton: UIBarButtonItem!
    
    init(episode: Episode, repositories: Repositories) {
        self.episode = episode
        self.repositories = repositories
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureScrollView()
        layoutDetailsCard()
        layoutCharactersCard()
        configureUIElements()
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissViewController))
        
        navigationItem.rightBarButtonItem = closeButton
        title = episode.name
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func layoutDetailsCard() {
        contentView.addSubview(detailsHeaderLabel, detailsCard)
        
        let padding: CGFloat = 16
        
        NSLayoutConstraint.activate([
            detailsHeaderLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            detailsHeaderLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 24),
            detailsHeaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            detailsHeaderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            detailsCard.topAnchor.constraint(equalTo: detailsHeaderLabel.bottomAnchor, constant: 4),
            detailsCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            detailsCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
        ])
        
        var previousBottomAnchor = detailsCard.topAnchor
        
        for view in [nameDetail, airDateDetail, episodeDetail] {
            detailsCard.addSubview(view)
            
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: previousBottomAnchor, constant: padding),
                view.leadingAnchor.constraint(equalTo: detailsCard.leadingAnchor, constant: padding),
                view.trailingAnchor.constraint(equalTo: detailsCard.trailingAnchor, constant: -padding),
                view.heightAnchor.constraint(greaterThanOrEqualToConstant: 24)
            ])
            
            previousBottomAnchor = view.bottomAnchor
        }
        
        NSLayoutConstraint.activate([
            previousBottomAnchor.constraint(equalTo: detailsCard.bottomAnchor, constant: -padding)
        ])
    }
    
    private func layoutCharactersCard() {
        contentView.addSubview(charactersHeaderLabel, charactersCard)
        
        let padding: CGFloat = 16
        
        NSLayoutConstraint.activate([
            charactersHeaderLabel.topAnchor.constraint(equalTo: detailsCard.bottomAnchor, constant: padding),
            charactersHeaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            charactersHeaderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            charactersCard.topAnchor.constraint(equalTo: charactersHeaderLabel.bottomAnchor, constant: 4),
            charactersCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            charactersCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            charactersCard.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
        
        var previousBottomAnchor = charactersCard.topAnchor
        
        
        for (idx, character) in episode.characters.enumerated() {
            let characterButton: OpenButton = .init(title: character)
            characterButton.tag = idx
            characterButton.addTarget(self, action: #selector(openCharacter), for: .touchUpInside)
            characterButtons.append(characterButton)
            charactersCard.addSubview(characterButton)

            NSLayoutConstraint.activate([
                characterButton.topAnchor.constraint(equalTo: previousBottomAnchor, constant: padding),
                characterButton.leadingAnchor.constraint(equalTo: charactersCard.leadingAnchor, constant: padding),
                characterButton.trailingAnchor.constraint(equalTo: charactersCard.trailingAnchor, constant: -padding)
            ])

            previousBottomAnchor = characterButton.bottomAnchor
        }
        
        NSLayoutConstraint.activate([
            previousBottomAnchor.constraint(equalTo: charactersCard.bottomAnchor, constant: -padding)
        ])
    }
    
    private func configureUIElements() {
        detailsHeaderLabel.text = NSLocalizedString(
            "header.episode.episodeDetails", comment: "The header label for the episode's details section.")
        nameDetail.set(detail: episode.name)
        airDateDetail.set(detail: episode.airDate)
        episodeDetail.set(detail: episode.episode)
        
        charactersHeaderLabel.text = NSLocalizedString(
            "header.episode.characters", comment: "The header label for the episode's characters section.")
    }
    
    @objc private func openCharacter(sender: UIButton) {
        let characterUrlString = episode.characters[sender.tag]
        
        repositories.character.fetch(by: characterUrlString) { result in
            switch result {
                case .success(let character):
                    self.present(character)
                case .failure(let error):
                    self.presentErrorAlert(error: .init(title: AlertTitles.couldntFetchCharacter, error: error))
            }
        }
    }
    
    private func present(_ character: Character) {
        DispatchQueue.main.async {
            let characterViewController = CharacterViewController(character: character, repositories: self.repositories)
            let navigationController = UINavigationController(rootViewController: characterViewController)
            self.present(navigationController, animated: true)
        }
    }
}
