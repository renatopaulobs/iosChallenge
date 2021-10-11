import UIKit

class PhotoTableViewController: UITableViewController {

    var albumId = Int()
    var userName = String()
    var photos = [Photo]()
    
    private let viewModel = PhotoViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Fotos de \(userName)"
        tableView.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotoCell")
        fillPhotos(from: albumId)
    }
    
    private func fillPhotos(from albumId: Int) {
        viewModel.fetchPhotos(albumId: albumId)
        viewModel.photos.bind{ [weak self] usersResponse in
            self?.photos = usersResponse
            self?.tableView.reloadData()
        }
    
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? PhotoTableViewCell else {
            return UITableViewCell()
        }

        let photo = photos[indexPath.row]
        cell.titleLabel.text = photo.title

        JsonPlaceholderService.downloadResource(resourceUrl: photo.thumbnailUrl){ response in
            if (response != nil){
                cell.photoImageView.image = UIImage(data: response!)
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        
        JsonPlaceholderService.downloadResource(resourceUrl: photo.thumbnailUrl){ response in
            if (response != nil){
                self.performSegue(withIdentifier: "photoToDetail",
                                  sender: (photo: UIImage(data: response!), name: photo.title))
            }
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinatinVC = segue.destination as? DetailsViewController {
            if let info = sender as? (photo: UIImage, name: String) {
                destinatinVC.photo = info.photo
                destinatinVC.name = info.name
            }
        }
    }
}
