//
//  ViewController.swift
//  TestAppProficiency
//
//  Created by user167484 on 3/17/20.
//  Copyright © 2020 Allen Savio. All rights reserved.
//c

import UIKit

class ViewController: UIViewController {
    //MARK: - Properties
    lazy var tableview: TableView = TableView(sender: self)
    
    var cellModels: [RowViewModel] = []
    private var imageCache = NSCache<NSString, UIImage>()
    
    //MARK: - Default Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .gray
        tableSetup()
        fetchData()
    }
    
    //MARK: - TableviewSetup
    func tableSetup() {
        tableview.refreshControl?.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        tableview.register(ImageLoadTableViewCell.self, forCellReuseIdentifier: "imageDetailCell")
    }
    
    //MARK: - Data Loader
    @objc func fetchData() {
        tableview.refreshControl?.beginRefreshing()
        imageCache.removeAllObjects()
        Request.fetchData.execute(success: { [weak self] (response, data: DataModel) in
            self?.tableview.refreshControl?.endRefreshing()
            self?.navigationItem.title = data.title ?? ""
            let models = data.data ?? []
            models.forEach { [weak self] model in
                let cellModel = ImageCellViewModel(model: model, cache: self?.imageCache)
                self?.cellModels.append(cellModel)
            }
            self?.tableview.reloadData()
        }, failure: { [weak self] (error) in
            self?.tableview.refreshControl?.endRefreshing()
            self?.showAlert(error: error)
        })
    }
}

//MARK: - Tableview Delegates and DataSources
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = cellModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.identifier)
        if let cellConfiguration = cell as? CellConfiguration  {
            cellConfiguration.setup(viewModel: cellModel)
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
}

//MARK: - Alert
extension ViewController {
    func showAlert(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}
