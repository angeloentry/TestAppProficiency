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
    var tableview: UITableView = UITableView()
    let refreshControl = UIRefreshControl()
    
    var tableData: [Model] = []
    private var imageCache = NSCache<NSString, UIImage>()
    
    //MARK: - Default Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .gray
        view.addSubview(tableview)
        tableSetup()
        fetchData()
    }
    
    //MARK: - TableviewSetup
    func tableSetup() {
        tableview.translatesAutoresizingMaskIntoConstraints = false
        setup()
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        tableview.refreshControl = refreshControl
        tableview.delegate = self
        tableview.dataSource = self
        tableview.estimatedRowHeight = 100
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(ImageLoadTableViewCell.self, forCellReuseIdentifier: "imageDetailCell")
    }
    
    func setup() {
        let a = NSLayoutConstraint(item: tableview, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leadingMargin, multiplier: 1, constant: 0)
        let b = NSLayoutConstraint(item: tableview, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailingMargin, multiplier: 1, constant: 0)
        let c = NSLayoutConstraint(item: tableview, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1, constant: 0)
        let d = NSLayoutConstraint(item: tableview, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([a,b,c,d])
    }
    
    //MARK: - Data Loader
    @objc func fetchData() {
        refreshControl.beginRefreshing()
        imageCache.removeAllObjects()
        Request.fetchData.execute(success: { [weak self] (response, data: DataModel) in
            self?.refreshControl.endRefreshing()
            self?.navigationItem.title = data.title ?? ""
            self?.tableData = data.data ?? []
            self?.tableview.reloadData()
        }, failure: { [weak self] (error) in
            self?.refreshControl.endRefreshing()
            self?.showAlert(error: error)
        })
    }
    
    
}

//MARK: - Tableview Delegates and DataSources
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageDetailCell") as! ImageLoadTableViewCell
        cell.imageContent.image = nil
        if let image = imageCache.object(forKey: NSString(string: "\(indexPath.row)")) {
            cell.imageContent.image = image
        } else {
            cell.imageContent.setImage(url: tableData[indexPath.row].image) { [weak self] (image) in
                self?.imageCache.setObject(image, forKey: NSString(string: "\(indexPath.row)"))
            }
        }
        
        cell.titleLabel.text = tableData[indexPath.row].title
        cell.descLabel.text = tableData[indexPath.row].desc
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
}

//MARK: - Imageview Utilities
extension UIImageView {
    typealias ImageCompletion = (_ image: UIImage) -> Void
    func setImage(url: String?, completion: @escaping ImageCompletion) {
        image = .checkmark
        guard let url = url else { return }
        Request.fetchImage(url: url).execute(success: { [weak self] (response, data: Data) in
            guard let image = UIImage(data: data) else { return }
            self?.image = image
            completion(image)
        }, failure: { (error) in
            print(error)
        })
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
