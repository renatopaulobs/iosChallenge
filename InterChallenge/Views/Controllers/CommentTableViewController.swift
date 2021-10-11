import UIKit

class CommentTableViewController: UITableViewController {
    
    var postId = Int()
    var userName = String()
    var comments = [Comment]()
    
    private let viewModel = CommentViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Comentários de \(userName)"
        tableView.register(UINib(nibName: "TitleAndDescriptionTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "TitleAndDescriptionCell")
        fillComments(from: postId)
    }
    
    private func fillComments(from postId: Int) {
        viewModel.fetchComments(postId: postId)
        viewModel.comments.bind{ [weak self] commentsResponse in
            self?.comments = commentsResponse
            self?.tableView.reloadData()
        }
   }

   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
   }
    
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TitleAndDescriptionCell", for: indexPath) as? TitleAndDescriptionTableViewCell else {
            return UITableViewCell()
        }

        let comment = comments[indexPath.row]
        cell.selectionStyle = .none
        cell.titleLabel.text = comment.name
        cell.descriptionLabel.text = comment.body

        return cell
    }
}
