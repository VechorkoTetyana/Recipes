import UIKit
import SnapKit
import SDWebImage

class IngredientCell: UITableViewCell {
    static let reuseIdentifier = "IngredientCell"

    private let ingredientImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.textAlignment = .right
        return label
    }()
    
    private let backgroundContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 18
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        selectionStyle = .none
        
        contentView.backgroundColor = .background
        contentView.addSubview(backgroundContainer)
        backgroundContainer.addSubview(ingredientImageView)
        backgroundContainer.addSubview(nameLabel)
        backgroundContainer.addSubview(amountLabel)

        backgroundContainer.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-12)
            make.height.equalTo(64)
        }

        ingredientImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(14)
            make.centerY.equalToSuperview()
            make.width.equalTo(54)
            make.height.equalTo(48)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(ingredientImageView.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
        }
        
        amountLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-14)
            make.centerY.equalToSuperview()
            make.leading.greaterThanOrEqualTo(nameLabel.snp.trailing).offset(8)
        }
    }
    
    func configure(with ingredient: Ingredient) {
        nameLabel.text = ingredient.name
        amountLabel.text = ingredient.amount
        ingredientImageView.sd_setImage(with: URL(string: ingredient.imageUrl), placeholderImage: UIImage(named: "placeholder_ingredient"))
    }
}


