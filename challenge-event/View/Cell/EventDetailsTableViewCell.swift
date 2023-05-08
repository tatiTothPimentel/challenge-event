import UIKit

protocol EventDetailsTableViewDelegate: AnyObject {
    func sharingAction()
    func checkInAction()
}

class EventDetailsTableViewCell: UITableViewCell {

    weak var delegate: EventDetailsTableViewDelegate?
    static let identifier = "EventDetailsTableViewCell"
    
    lazy var eventImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.image = UIImage(named: "events")
        image.layer.cornerRadius = 8
        image.layer.masksToBounds = true
        image.layer.borderColor = .init(red: 0.6, green: 0.4, blue: 100.0, alpha: 1)
        image.layer.borderWidth = 3

        return image
    }()
    
    lazy var dataStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, dateLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10

        return stackView
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sharingButton, checkInButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 10

        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hackathon Social Woop Sicredi"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "11/01/22"
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0

        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Vamos ajudar !!\n Se você tem na sua casa roupas que estão em bom estado de uso e não sabemos que fazer, coloque aqui na nossa página sua cidade e sua doação, com certeza poderá ajudar outras pessoas que estão passando por problemas econômicos no momento!!\n Ajudar não faz mal a ninguém!!!\n"
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .black

        return label
    }()
    
    lazy var sharingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Compartilhamento", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.titleLabel?.textColor = .white
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .init(red: 0.6, green: 0.4, blue: 100.0, alpha: 1)
        button.layer.cornerRadius = 5
//        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(sharingAction), for: .touchUpInside)
        return button
    }()
    
    lazy var checkInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Check in", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.titleLabel?.textColor = .white
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .init(red: 0.6, green: 0.4, blue: 100.0, alpha: 1)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(checkInAction), for: .touchUpInside)
        return button
    }()
    
    @objc func sharingAction() {
        delegate?.sharingAction()
    }
    
    @objc func checkInAction() {
        delegate?.checkInAction()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
        contentView.isUserInteractionEnabled = true
    }
    
    private func setConstraints() {
        contentView.addSubview(eventImage)
        contentView.addSubview(dataStackView)
        contentView.addSubview(buttonStackView)
        
        eventImage.translatesAutoresizingMaskIntoConstraints = false
        dataStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            eventImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            eventImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            eventImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            eventImage.heightAnchor.constraint(equalToConstant: 250),
            
            dataStackView.topAnchor.constraint(equalTo: eventImage.bottomAnchor, constant: 24),
            dataStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            dataStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            buttonStackView.topAnchor.constraint(equalTo: dataStackView.bottomAnchor, constant: 24),
            buttonStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            buttonStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            buttonStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            sharingButton.heightAnchor.constraint(equalToConstant: 50),
            checkInButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
