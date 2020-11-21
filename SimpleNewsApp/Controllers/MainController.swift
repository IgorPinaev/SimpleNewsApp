//
//  MainController.swift
//  SimpleNewsApp
//
//  Created by Игорь Пинаев on 20.11.2020.
//

import UIKit
import CoreData

class MainController: UIViewController {
    private let customView = MainView()
    private let articlesService = ArticlesService()
    private var frcSerivce: FetchedResultsService<Article>?
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.tableView.dataSource = self
        customView.tableView.dataSource = self
        configureFrcService()
        
        loadArticles()
    }
}

private extension MainController {
    func configureFrcService() {
        frcSerivce = FetchedResultsService(delegate: self, sortDescriptors: [NSSortDescriptor(key: "publishedAt", ascending: false)])
    }
    
    func loadArticles(page: Int = 1) {
        articlesService.getArticles(from: page) { error in
            print(error?.localizedDescription)
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
                customView.tableView.insertRows(at: [indexPath], with: .top)
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
