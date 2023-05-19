import UIKit

protocol EventListCellDelegate: AnyObject {
    func moreDetailsAction(viewModel: EventViewModel)
}

class EventListCell: UITableViewCell {
    
    weak var delegate: EventListCellDelegate?
    static let identifier = "EventListCell"
    var viewModel: EventViewModel?
    
    lazy var eventImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = self.frame.height / 2.0
        image.layer.masksToBounds = true
        image.image = UIImage(named: "imageDefault")

        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .black
        
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        label.textColor = .black

        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, dateLabel, seeMoreButton])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 2

        return stackView
    }()
    
    lazy var seeMoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ver mais", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.init(red: 0, green: 0.412, blue: 0.816, alpha: 1), for: .normal)
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector (moreDetailsAction), for: .touchUpInside)
        return button
    }()
    
    @objc func moreDetailsAction() {
        guard let viewModel = viewModel  else { return }
        delegate?.moreDetailsAction(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    func configure(viewModel: EventViewModel?) {
        contentView.backgroundColor = .white
        self.viewModel = viewModel
        guard let viewModel = viewModel else { return }
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.date
        eventImage.downloaded(from: viewModel.image, contentMode: .scaleAspectFill)
    }
    
    private func setConstraints() {
        contentView.addSubview(eventImage)
        contentView.addSubview(stackView)
        
        eventImage.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            eventImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            eventImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            eventImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            eventImage.heightAnchor.constraint(equalToConstant: 150),
            eventImage.widthAnchor.constraint(equalToConstant: 150),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: eventImage.trailingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
        ])
    }
}
