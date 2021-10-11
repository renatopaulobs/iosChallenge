import Alamofire
import UIKit

class PostTableViewController: UITableViewController {
    
    var userId = Int()
    var userName = String()
    var posts = [Post]()

    private let viewModel = PostViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Postagens de \(userName)"
        tableView.register(UINib(nibName: "TitleAndDescriptionTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "TitleAndDescriptionCell")
        fillPosts(from: userId)
    }
    
    private func fillPosts(from userId: Int) {
        viewModel.getPostsBy(userId: userId)
        viewModel.posts.bind{ [weak self] postsResponse in
            self?.posts = postsResponse
            self?.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TitleAndDescriptionCell", for: indexPath) as? TitleAndDescriptionTableViewCell else {
            return UITableViewCell()
        }

        let post = posts[indexPath.row]
        cell.titleLabel.text = post.title
        cell.descriptionLabel.text = post.body

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postId = posts[indexPath.row].id
        performSegue(withIdentifier: "postToComment", sender: postId)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinatoinVC = segue.destination as? CommentTableViewController {
            if let postId = sender as? Int {
                destinatoinVC.userName = userName
                destinatoinVC.postId = postId
            }
        }
    }
}
