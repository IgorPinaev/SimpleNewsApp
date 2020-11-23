//
//  MainController.swift
//  SimpleNewsApp
//
//  Created by Игорь Пинаев on 20.11.2020.
//

import UIKit
import CoreData
import SafariServices

class MainController: UIViewController {
    private let customView = MainView()
    private let articlesService = ArticlesService()
    
    private var frcSerivce: FetchedResultsService<Article>?
    private var currentPage = 1
    private var isLoading = false
    private var allDone = false
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "News"
        
        configureFrcService()
        configureTable()
        loadArticles()
    }
}

private extension MainController {
    func configureTable() {
        customView.tableView.dataSource = self
        customView.tableView.delegate = self
        
        customView.tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    func configureFrcService() {
        frcSerivce = FetchedResultsService(delegate: self, sortDescriptors: [NSSortDescriptor(key: "publishedAt", ascending: false)])
    }
    
    func loadArticles() {
        isLoading = true
        
        let beforeLoadingCount = currentPage == 1 ? 0 : frcSerivce?.frc.fetchedObjects?.count ?? 0
        
        articlesService.getArticles(from: currentPage) { [weak self] error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                self?.customView.refreshControl.endRefreshing()
                self?.customView.tableView.tableFooterView?.isHidden = true
                
                if let error = error {
                    self?.showError(error: error)
                } else {
                    self?.allDone = self?.frcSerivce?.frc.fetchedObjects?.count ?? 0 == beforeLoadingCount
                    self?.currentPage += 1
                }
            }
        }
    }
    
    @objc func refresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self else { return }
            
            self.currentPage = 1
            self.loadArticles()
        }
    }
}

extension MainController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        frcSerivce?.frc.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let article = frcSerivce?.frc.object(at: indexPath) else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableCell.reuseId) as! ArticleTableCell
        cell.fill(article)
        return cell
    }
}

extension MainController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        customView.tableView.deselectRow(at: indexPath, animated: true)
        
        guard let urlString = frcSerivce?.frc.object(at: indexPath).url, let url = URL(string: urlString) else {
            return
        }

        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if allDone || isLoading { return }

        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

        if maximumOffset - scrollView.contentOffset.y <= 0 {
            customView.tableView.tableFooterView?.isHidden = false
            loadArticles()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
}

extension MainController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        customView.tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                customView.tableView.insertRows(at: [indexPath], with: .none)
            }
        case .delete:
            if let indexPath = indexPath {
                customView.tableView.deleteRows(at: [indexPath], with: .none)
            }
        case .update:
            if let indexPath = indexPath {
                customView.tableView.reloadRows(at: [indexPath], with: .none)
            }
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        customView.tableView.endUpdates()
    }
}
