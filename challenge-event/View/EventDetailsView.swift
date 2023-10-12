import UIKit

protocol DetailsViewDelegate: AnyObject {
    func sharingAction()
    func checkInAction()
}

class EventDetailsView: UIView {
    
    weak var delegate: DetailsViewDelegate?
    private var eventViewModel: EventViewModel?

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.register(EventDetailsCell.self, forCellReuseIdentifier: EventDetailsCell.identifier)
        tableView.dataSource = self
        
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

extension EventDetailsView {
    func configure(viewModel: EventViewModel) {
        eventViewModel = viewModel
        tableView.reloadData()
    }
}

extension EventDetailsView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventDetailsCell.identifier, for: indexPath) as? EventDetailsCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.delegate = self
        cell.configure(viewModel: eventViewModel)
        return cell
    }
}

extension EventDetailsView: EventDetailsCellDelegate {
    func checkInAction() {
        delegate?.checkInAction()
    }
    
    func sharingAction() {
        delegate?.sharingAction()
    }
}
