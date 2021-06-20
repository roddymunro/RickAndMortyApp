//
//  CharacterViewController.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 19/06/2021.
//

import UIKit

class CharacterViewController: UIViewController {
    
    private var character: Character!
    private var repository: CharacterRepository!
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let imageView = CharacterImageView(frame: .zero)
    
    let detailsCard = CardView()
    let detailsHeaderLabel = TitleLabel(textAlignment: .left)
    let nameDetail = DetailView(title: "Name")
    let statusDetail = DetailView(title: "Status")
    let speciesDetail = DetailView(title: "Species")
    let typeDetail = DetailView(title: "Type")
    let genderDetail = DetailView(title: "Gender")
    let originDetail = DetailButtonView(title: "Origin")
    let locationDetail = DetailButtonView(title: "Location")
    
    let episodesCard = CardView()
    let episodesHeaderLabel = TitleLabel(textAlignment: .left)
    var episodeButtons: [OpenButton] = []
    
    var closeButton: UIBarButtonItem!
    
    init(character: Character, repository: CharacterRepository) {
        super.init(nibName: nil, bundle: nil)
        self.character = character
        self.repository = repository
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureScrollView()
        layoutHeaderElements()
        layoutDetailsCard()
        layoutEpisodesCard()
        configureUIElements()
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissViewController))
        
        navigationItem.rightBarButtonItem = closeButton
        title = character.name
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
    
    private func layoutHeaderElements() {
        contentView.addSubview(imageView)
        
        let padding: CGFloat = 16
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            imageView.heightAnchor.constraint(equalToConstant: 96),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    private func layoutDetailsCard() {
        contentView.addSubview(detailsHeaderLabel, detailsCard)
        
        let padding: CGFloat = 16
        
        NSLayoutConstraint.activate([
            detailsHeaderLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding),
            detailsHeaderLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 24),
            detailsHeaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            detailsHeaderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            detailsCard.topAnchor.constraint(equalTo: detailsHeaderLabel.bottomAnchor, constant: 4),
            detailsCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            detailsCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
        ])
        
        var previousBottomAnchor = detailsCard.topAnchor
        
        for view in [nameDetail, statusDetail, speciesDetail, typeDetail, genderDetail, originDetail, locationDetail] {
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
    
    private func layoutEpisodesCard() {
        contentView.addSubview(episodesHeaderLabel, episodesCard)
        
        let padding: CGFloat = 16
        
        NSLayoutConstraint.activate([
            episodesHeaderLabel.topAnchor.constraint(equalTo: detailsCard.bottomAnchor, constant: padding),
            episodesHeaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            episodesHeaderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            episodesCard.topAnchor.constraint(equalTo: episodesHeaderLabel.bottomAnchor, constant: 4),
            episodesCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            episodesCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            episodesCard.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
        
        var previousBottomAnchor = episodesCard.topAnchor

        for episode in character.episode {
            let episodeButton: OpenButton = .init(title: episode)
            episodeButtons.append(episodeButton)
            episodesCard.addSubview(episodeButton)

            NSLayoutConstraint.activate([
                episodeButton.topAnchor.constraint(equalTo: previousBottomAnchor, constant: padding),
                episodeButton.leadingAnchor.constraint(equalTo: episodesCard.leadingAnchor, constant: padding),
                episodeButton.trailingAnchor.constraint(equalTo: episodesCard.trailingAnchor, constant: -padding)
            ])

            previousBottomAnchor = episodeButton.bottomAnchor
        }
        
        NSLayoutConstraint.activate([
            previousBottomAnchor.constraint(equalTo: episodesCard.bottomAnchor, constant: -padding)
        ])
    }
    
    private func configureUIElements() {
        imageView.downloadImage(from: character.image)
        
        detailsHeaderLabel.text = "Character Details"
        nameDetail.set(detail: character.name)
        statusDetail.set(detail: character.status)
        speciesDetail.set(detail: character.species)
        typeDetail.set(detail: character.type)
        genderDetail.set(detail: character.gender)
        originDetail.set(detail: character.origin.name)
//        originDetail.detailButton.addTarget(self, action: #selector(openLocation), for: .touchUpInside)
        
        locationDetail.set(detail: character.location.name)
//        locationDetail.detailButton.addTarget(self, action: #selector(openLocation), for: .touchUpInside)
        
        episodesHeaderLabel.text = "Episodes"
        
    }
    
    @objc private func openLocation() {
        
    }
}
