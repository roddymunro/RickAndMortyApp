//
//  CharacterListViewController.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-18.
//

import UIKit

class CharacterListViewController: UIViewController {

    private var repository: CharacterRepository!
    
    init(repository: CharacterRepository) {
        super.init(nibName: nil, bundle: nil)
        self.repository = repository
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
