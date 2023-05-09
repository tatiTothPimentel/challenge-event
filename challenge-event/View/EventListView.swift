import UIKit

protocol EventListViewDelegate: AnyObject {
    func moreDetailsAction()
}

class EventListView: UIView {
    
    weak var delegate: EventListViewDelegate?
    private var eventListViewModel: EventListViewModel?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = true
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.register(EventListTableViewCell.self, forCellReuseIdentifier: EventListTableViewCell.identifier)
        
        return tableView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        setConstraints()
    }
    
    private func setConstraints() {
        backgroundColor = .white
        
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ])
        
    }
}

extension EventListView {
    func configure(viewModel: EventListViewModel?) {
        eventListViewModel = viewModel
        tableView.reloadData()
    }
}

extension EventListView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return eventListViewModel?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventListViewModel?.numberOfRowsInSection(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventListTableViewCell.identifier, for: indexPath) as? EventListTableViewCell else {
            return UITableViewCell()
        }
        
        let eventViewModel = eventListViewModel?.eventAtIndex(indexPath.row)
        cell.configure(viewModel: eventViewModel)
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
}

extension EventListView: EventListTableViewCellDelegate {
    func moreDetailsAction() {
        delegate?.moreDetailsAction()
    }
}
