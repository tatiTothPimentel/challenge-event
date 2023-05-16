import UIKit

class EventListViewController: UIViewController {
    var eventListView = EventListView()

    override func loadView() {
        eventListView.delegate = self
        view = eventListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }

    private func fetchData() {
        
        WebService.getEvents() { eventList in
            
            if let event = eventList {
                let eventListViewModel = EventListViewModel(events: event)
                
                DispatchQueue.main.async {
                    self.eventListView.configure(viewModel: eventListViewModel)
                }
            }
        }
        
    }
}

extension EventListViewController: EventListViewDelegate {
    func moreDetailsAction(viewModel: EventViewModel) {
        let detailsViewController = EventDetailsViewController(eventViewModel: viewModel)
//        detailsViewController.modalPresentationStyle = .fullScreen
        present(detailsViewController, animated: true)
    }
}
