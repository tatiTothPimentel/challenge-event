import UIKit

protocol EventListTableViewDelegate: AnyObject {
    func moreDetailsAction()
}

class EventListTableViewCell: UITableViewCell {
    
    weak var delegate: EventListTableViewDelegate?
    static let identifier = "EventListTableViewCell"
    
    lazy var eventImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "events")
        image.layer.cornerRadius = self.frame.height / 2.0
        image.layer.masksToBounds = true
        image.layer.borderColor = .init(red: 0.6, green: 0.4, blue: 100.0, alpha: 1)
        image.layer.borderWidth = 3

        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hackathon Social Woop Sicredi"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .black
        
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "11/01/22"
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        label.textColor = .black

        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, dateLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 2

        return stackView
    }()
    
    lazy var seeMoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ver mais", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .init(red: 0.6, green: 0.4, blue: 100.0, alpha: 1)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector (moreDetailsAction), for: .touchUpInside)
        return button
    }()
    
    @objc func moreDetailsAction() {
        delegate?.moreDetailsAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    private func setConstraints() {
        contentView.addSubview(eventImage)
        contentView.addSubview(stackView)
        contentView.addSubview(seeMoreButton)
        
        eventImage.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        seeMoreButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            eventImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            eventImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            eventImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            eventImage.heightAnchor.constraint(equalToConstant: 150),
            eventImage.widthAnchor.constraint(equalToConstant: 150),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: eventImage.trailingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            seeMoreButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 24),
            seeMoreButton.leadingAnchor.constraint(equalTo: eventImage.trailingAnchor, constant: 16),
            seeMoreButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            seeMoreButton.heightAnchor.constraint(equalToConstant: 50),
            seeMoreButton.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
}
