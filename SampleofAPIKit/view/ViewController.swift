//
//  ViewController.swift
//  SampleofAPIKit
//
//  Created by 横山新 on 2019/02/24.
//  Copyright © 2019 ARATAYOKOYAMA. All rights reserved.
//

import UIKit
import RxSwift
import APIKit

class ViewController: UIViewController {
    
    private let viewModel = GitHubListViewModel()
    private var dataSource = [Repository]()
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "RepositoryTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "RepositoryTableViewCell")
        
        viewModel.repository
            .bind { [weak self] repos in
                self?.reloadData(repos)
            }
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.reloadData(userName: "ARATAYOKOYAMA")
    }

    private func reloadData(_ data: [Repository]) {
        dataSource = data
        tableView.reloadData()
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryTableViewCell", for: indexPath) as! RepositoryTableViewCell
        cell.configure(item)
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
}

