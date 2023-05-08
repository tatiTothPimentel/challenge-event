import UIKit

class EventDetailsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let detailsView = DetailsView()
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
