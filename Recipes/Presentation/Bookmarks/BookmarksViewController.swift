import UIKit

class BookmarksViewController: UIViewController {
    var coordinator: Coordinator?
    
    private let viewModel: BookmarksViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RecipeCell.self, forCellReuseIdentifier: "RecipeCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .background
        return tableView
    }()
    
    init(viewModel: BookmarksViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRecipes()
    }
    
    private func fetchRecipes() {
        Task { [weak self] in
            await self?.viewModel.loadBookmarkedRecipes()
            self?.tableView.reloadData()
        }
    }
    
    private func bindShowError() {
        viewModel.showError = { [weak self] text in
            self?.showErrorAllert(message: text)
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .background
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension BookmarksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.bookmarkedRecipes.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        let recipe = viewModel.bookmarkedRecipes[indexPath.row]
        cell.configure(with: recipe)
        return cell
    }
}

extension BookmarksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = viewModel.bookmarkedRecipes[indexPath.row]
        viewModel.didSelectRecipe?(recipe)
    }
}
