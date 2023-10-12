import UIKit

class EventListViewController: UIViewController {
    
    private var eventListViewModel: EventListViewModel? {
        didSet {
            self.tableView.reloadData()
        }
    }

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        self.tableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "EventTableViewCell")
        navigationItem.title = "EVENTOS"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.gray]
        navigationController?.navigationBar.barTintColor = UIColor.white

        fetchData()
    }

    private func fetchData() {
        
        WebService.getEvents() { eventList in
            
            if let event = eventList {
                
                DispatchQueue.main.async {
                    self.eventListViewModel = EventListViewModel(events: event)
                }
            }
        }
        
    }
}

extension EventListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return eventListViewModel?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventListViewModel?.numberOfRowsInSection(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as? EventTableViewCell else {
            return UITableViewCell()
        }
        
        let eventViewModel = eventListViewModel?.eventAtIndex(indexPath.row)
        cell.configure(viewModel: eventViewModel)
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
}

extension EventListViewController: EventListCellDelegate {
    func moreDetailsAction(viewModel: EventViewModel) {
        let detailsViewController = EventDetailsViewController(eventViewModel: viewModel)
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
