import UIKit
import SnapKit
import SDWebImage

class RecipeCell: UITableViewCell {
    
    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 18
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .background
        contentView.addSubview(recipeImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(durationLabel)
        
        recipeImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.width.height.equalTo(80)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(recipeImageView.snp.trailing).offset(12)
            make.top.equalToSuperview().offset(17)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        durationLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
        }
    }
    
    func configure(with recipe: Recipe) {
        nameLabel.text = recipe.name
        durationLabel.text = "\(recipe.duration) min"
        
        if let url = URL(string: recipe.imageUrl) {
            recipeImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder_recipe"), options: [], completed: nil)
        } else {
            recipeImageView.image = UIImage(named: "placeholder_recipe")
        }
        
        func prepareForReuse() {
            super.prepareForReuse()
            
            recipeImageView.sd_cancelCurrentImageLoad()
        }
    }
}


