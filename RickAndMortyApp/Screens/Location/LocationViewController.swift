//
//  LocationViewController.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 19/06/2021.
//

import UIKit

class LocationViewController: UIViewController {
    
    private var location: Location!
    private var repositories: Repositories
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let detailsCard = CardView()
    let detailsHeaderLabel = TitleLabel(textAlignment: .left)
    let nameDetail = DetailView(title: NSLocalizedString(
        "label.location.name", comment: "The label for the location's name detail."))
    let typeDetail = DetailView(title: NSLocalizedString(
        "label.location.type", comment: "The label for the location's type detail."))
    let dimensionDetail = DetailView(title: NSLocalizedString(
        "label.location.dimension", comment: "The label for the location's dimension detail."))
    
    let residentsCard = CardView()
    let residentsHeaderLabel = TitleLabel(textAlignment: .left)
    var residentButtons: [OpenButton] = []
    
    var closeButton: UIBarButtonItem!
    
    init(location: Location, repositories: Repositories) {
        self.location = location
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
        layoutResidentsCard()
        configureUIElements()
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissViewController))
        
        navigationItem.rightBarButtonItem = closeButton
        title = location.name
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
        
        for view in [nameDetail, typeDetail, dimensionDetail] {
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
    
    private func layoutResidentsCard() {
        contentView.addSubview(residentsHeaderLabel, residentsCard)
        
        let padding: CGFloat = 16
        
        NSLayoutConstraint.activate([
            residentsHeaderLabel.topAnchor.constraint(equalTo: detailsCard.bottomAnchor, constant: padding),
            residentsHeaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            residentsHeaderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            residentsCard.topAnchor.constraint(equalTo: residentsHeaderLabel.bottomAnchor, constant: 4),
            residentsCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            residentsCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            residentsCard.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
        
        var previousBottomAnchor = residentsCard.topAnchor

        for (idx, resident) in location.residents.enumerated() {
            let residentButton: OpenButton = .init(title: resident)
            residentButton.tag = idx
            residentButton.addTarget(self, action: #selector(openCharacter), for: .touchUpInside)
            residentButtons.append(residentButton)
            residentsCard.addSubview(residentButton)

            NSLayoutConstraint.activate([
                residentButton.topAnchor.constraint(equalTo: previousBottomAnchor, constant: padding),
                residentButton.leadingAnchor.constraint(equalTo: residentsCard.leadingAnchor, constant: padding),
                residentButton.trailingAnchor.constraint(equalTo: residentsCard.trailingAnchor, constant: -padding)
            ])

            previousBottomAnchor = residentButton.bottomAnchor
        }
        
        NSLayoutConstraint.activate([
            previousBottomAnchor.constraint(equalTo: residentsCard.bottomAnchor, constant: -padding)
        ])
    }
    
    private func configureUIElements() {
        detailsHeaderLabel.text = NSLocalizedString(
            "header.location.locationDetails", comment: "The header label for the location's details section.")
        nameDetail.set(detail: location.name)
        typeDetail.set(detail: location.type)
        dimensionDetail.set(detail: location.dimension)
        
        residentsHeaderLabel.text = NSLocalizedString(
            "header.location.residents", comment: "The header label for the location's residents section.")
    }
    
    @objc private func openCharacter(sender: UIButton) {
        let characterUrlString = location.residents[sender.tag]
        
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
