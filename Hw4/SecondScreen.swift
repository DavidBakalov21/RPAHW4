//
//  SecondScreen.swift
//  Hw4
//
//  Created by david david on 08.11.2024.
//

import Foundation
import UIKit
import Combine
class SecondScreen: UIViewController {
     var cancellable = Set<AnyCancellable>()
    
    let tableView: UITableView = {
            let tableView = UITableView()
            tableView.register(BreedCell.self, forCellReuseIdentifier: "breedCell")
            return tableView
        }()
    let titleText = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        titleText.text = "Cats"
        tableView.accessibilityIdentifier = "breedsCats"
        titleText.accessibilityIdentifier = "catsLabel"
        tableView.delegate = self
               tableView.dataSource = self
               titleText.font = titleText.font.withSize(30)
        view.addSubview(titleText)
        view.addSubview(tableView)
               titleText.snp.makeConstraints {
                   $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                   $0.centerX.equalToSuperview()
               }
               tableView.snp.makeConstraints {
                   $0.top.equalTo(titleText.snp.bottom)
                   $0.leading.equalToSuperview()
                   $0.trailing.equalToSuperview()
                   $0.bottom.equalToSuperview()
               }
        // See ThirdScreen explanation since the code is mostly same
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.catFetcher.$catBreeds
                .receive(on: DispatchQueue.main)
                .sink { [weak self] _ in
                    self?.tableView.reloadData()
                }
                .store(in: &cancellable)
        }
    }
}

extension SecondScreen: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            return appDelegate.catFetcher.catBreeds.count
        }
        return 0
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "breedCell",
                                                       for: indexPath) as? BreedCell else {
            return UITableViewCell()
        }
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            cell.setupCell(with: appDelegate.catFetcher.catBreeds[indexPath.row])
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
