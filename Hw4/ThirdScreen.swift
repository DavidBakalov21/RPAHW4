//
//  ThirdScreen.swift
//  Hw4
//
//  Created by david david on 08.11.2024.
//

import Foundation
import UIKit
import Combine
final class ThirdScreen: UIViewController {
     var cancellable = Set<AnyCancellable>()
    
    let tableView: UITableView = {
            let tableView = UITableView()
            tableView.register(ImgCell.self, forCellReuseIdentifier: "imgCell")
            return tableView
        }()
    let titleText = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tableView.accessibilityIdentifier = "catsImages"
        titleText.accessibilityIdentifier = "likedLabel"
        titleText.text = "Liked Cats"
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
    // https://stackoverflow.com/questions/24046164/how-do-i-get-a-reference-to-the-appdelegate-in-swift
        // Basically all we are doing here is just monitoring liked changes, and if it changes then we
        // reload tableview. Mostly works just like observer patern.
        // Since liked array is @published, swift automatically creates a publisher fo it which can be accessed with "$"
        // receive is used to specify that liked will be modified on the main thread
        // inside sink we just react to value chnages
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.$liked
                .receive(on: DispatchQueue.main)
                .sink { [weak self] _ in
                    self?.tableView.reloadData()
                }
                .store(in: &cancellable)
        }
    }
}

extension ThirdScreen: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            return appDelegate.liked.count
        }
       return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "imgCell",
                                                       for: indexPath) as? ImgCell else {
            return UITableViewCell()
        }
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            cell.setupCell(with: appDelegate.liked[indexPath.row])
            return cell
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
