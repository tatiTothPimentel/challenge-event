import UIKit

protocol EventListCellDelegate: AnyObject {
    func moreDetailsAction(viewModel: EventViewModel)
}

class EventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    
    var viewModel: EventViewModel?
    weak var delegate: EventListCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(viewModel: EventViewModel?) {
        contentView.backgroundColor = .white
        self.viewModel = viewModel
        guard let viewModel = viewModel else { return }
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.date
        eventImage.downloaded(from: viewModel.image, contentMode: .scaleAspectFill)
                
        eventImage.layer.borderWidth = 2.0
        eventImage.layer.borderColor = UIColor.lightGray.cgColor
        eventImage.layer.cornerRadius = 10.0
    }
    
    @IBAction func showMoreDidTap(_ sender: Any) {
        guard let viewModel = viewModel  else { return }
        delegate?.moreDetailsAction(viewModel: viewModel)
    }
}
