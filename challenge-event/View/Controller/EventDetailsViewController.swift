import UIKit

class EventDetailsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let detailsView = EventDetailsView()
        detailsView.delegate = self
        view = detailsView
    }
}

extension EventDetailsViewController: DetailsViewDelegate {
    func checkInAction() {
        print("Tati lindona")
    }
    
    func sharingAction() {
        print("Tati arrasou")
    }
}
