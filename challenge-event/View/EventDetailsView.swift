import UIKit

protocol DetailsViewDelegate: AnyObject {
    func sharingAction()
    func checkInAction()
}

class EventDetailsView: UIView {
    
    weak var delegate: DetailsViewDelegate?

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(EventDetailsTableViewCell.self, forCellReuseIdentifier: EventDetailsTableViewCell.identifier)
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

extension EventDetailsView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventDetailsTableViewCell.identifier, for: indexPath) as? EventDetailsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
}

extension EventDetailsView: EventDetailsTableViewDelegate {
    func checkInAction() {
        delegate?.checkInAction()
    }
    
    func sharingAction() {
        delegate?.sharingAction()
    }
}
