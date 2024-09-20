import UIKit
import SnapKit

class RecipeDetailViewController: UIViewController {
    private let viewModel: RecipeDetailViewModel
    
    private lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView(frame: .zero, style: .plain)
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .background
        tableView.register(RecipeHeaderCell.self, forCellReuseIdentifier: RecipeHeaderCell.reuseIdentifier)
        tableView.register(IngredientCell.self, forCellReuseIdentifier: IngredientCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionHeaderTopPadding = 0
        
        return tableView
    }()
    
    init(viewModel: RecipeDetailViewModel) {
        self.viewModel = viewModel
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetch()
    }
    
    private func fetch() {
        Task { [weak self] in
            await self?.viewModel.loadRecipeDetail()
                self?.tableView.reloadData()
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .background
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "bookmark"),
            style: .plain,
            target: self,
            action: #selector(toggleBookmark)
        )
    }
    
    @objc private func toggleBookmark() {
        // viewModel.toggleBookmark()
    }
    
    private func updateBookmark(isBookmarked: Bool) {
        let imageName = isBookmarked ? "bookmark.fill" : "bookmark"
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: imageName)
    }
}

extension RecipeDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return viewModel.recipeDetail?.ingredients.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: RecipeHeaderCell.reuseIdentifier, for: indexPath) as! RecipeHeaderCell
            
            if let detail = viewModel.recipeDetail {
                cell.configure(with: detail)
            }
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: IngredientCell.reuseIdentifier, for: indexPath) as! IngredientCell
            if let ingredient = viewModel.recipeDetail?.ingredients[indexPath.row] {
                    cell.configure(with: ingredient)
                }
                return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let headerView = UIView()
            headerView.backgroundColor = .background
            
            let label = UILabel()
            label.text = "recipe.ingredients".localized
            label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            headerView.addSubview(label)
            
            label.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(24)
                make.top.bottom.equalToSuperview().inset(8)
            }
            
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 44 : 1
    }
}
