import UIKit

class ChallengeViewController: UITableViewController {
    
    var usersCount = 0
    private let viewModel = ChallengeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserCell")
        viewModel.usersCount.bind{ [weak self] usersResponse in
            self?.usersCount = usersResponse
            self?.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        viewModel.users.bind{ [weak self] usersResponse in
            let user = usersResponse[indexPath.row]
            cell.selectionStyle = .none
            cell.id = user.id
            cell.initialsLabel.text = String(user.name.prefix(2))
            cell.nameLabel.text = user.name
            cell.userNameLabel.text = user.username
            cell.emailLabel.text = user.email
            cell.phoneLabel.text = user.phone
            cell.delegate = self
            cell.contentView.backgroundColor = indexPath.row % 2 == 0 ? .white : UIColor(white: 0.667, alpha: 0.2)
        }
        return cell
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? AlbumTableViewController {
            if let info = sender as? (id: Int, name: String) {
                destinationVC.userId = info.id
                destinationVC.userName = info.name
            }
        }
        
        if let destinationVC = segue.destination as? PostTableViewController {
            if let info = sender as? (id: Int, name: String) {
                destinationVC.userId = info.id
                destinationVC.userName = info.name
            }
        }
    }
}

extension ChallengeViewController: UserTableViewCellDelegate {
    func didTapAlbums(with userId: Int, by name: String) {
        let userIdAndName = (id: userId, name: name)
        performSegue(withIdentifier: "challengeToAlbum", sender: userIdAndName)
    }
    
    func didTapPosts(with userId: Int, by name: String) {
        let userIdAndName = (id: userId, name: name)
        performSegue(withIdentifier: "challengeToPost", sender: userIdAndName)
    }
}
