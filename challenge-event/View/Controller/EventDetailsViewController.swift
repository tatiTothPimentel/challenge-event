import UIKit

class EventDetailsViewController: UIViewController {
    var eventViewModel: EventViewModel
    
    init(eventViewModel: EventViewModel) {
        self.eventViewModel = eventViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let detailsView = EventDetailsView()
        detailsView.delegate = self
        detailsView.configure(viewModel: eventViewModel)
        
        view = detailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor.black
    }
}

extension EventDetailsViewController: DetailsViewDelegate {
    func checkInAction() {
        print("Você está prestes a fazer o check in")
    }
    
    func sharingAction() {
        print("Você irá compartilhar o evento")
    }
}
