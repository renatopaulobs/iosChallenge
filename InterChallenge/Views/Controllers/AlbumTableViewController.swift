import UIKit

class AlbumTableViewController: UITableViewController {

    var userId = Int()
    var userName = String()
    var albums = [Album]()
    
    private let viewModel = AlbumViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Álbuns de \(userName)"
        tableView.register(UINib(nibName: "AlbumTableViewCell", bundle: nil), forCellReuseIdentifier: "AlbumCell")
        fillAlbums(from: userId)
    }
    
    private func fillAlbums(from userId: Int) {
        viewModel.fetchPhotos(userId: userId)
        viewModel.albums.bind{ [weak self] albums in
            self?.albums = albums
            self?.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as? AlbumTableViewCell else {
            return UITableViewCell()
        }

        let album = albums[indexPath.row]
        cell.albumNameLabel.text = album.title

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumId = albums[indexPath.row].id
        performSegue(withIdentifier: "albumToPhoto", sender: albumId)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinatoinVC = segue.destination as? PhotoTableViewController {
            if let albumId = sender as? Int {
                destinatoinVC.userName = userName
                destinatoinVC.albumId = albumId
            }
        }
    }
}
