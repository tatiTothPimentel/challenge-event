import UIKit

protocol EventListViewDelegate: AnyObject {
    func moreDetailsAction(viewModel: EventViewModel)
}

class EventListView: UIView {
    
    weak var delegate: EventListViewDelegate?
    private var eventListViewModel: EventListViewModel?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = true
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.register(EventListCell.self, forCellReuseIdentifier: EventListCell.identifier)
        
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventListCell.identifier, for: indexPath) as? EventListCell else {
            return UITableViewCell()
        }
        
        let eventViewModel = eventListViewModel?.eventAtIndex(indexPath.row)
        cell.configure(viewModel: eventViewModel)
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
}

extension EventListView: EventListCellDelegate {
    func moreDetailsAction(viewModel: EventViewModel) {
        delegate?.moreDetailsAction(viewModel: viewModel)
    }
}
