import UIKit

/// Demonstrates inspector on a `UITableView` with cells containing an image and a label.
///
/// Inspect any cell's `UIImageView` or `UILabel` to see their properties in the inspector panel.
final class TableViewExampleViewController: UIViewController {

    // MARK: - Model

    fileprivate struct Item {
        let name: String
        let symbol: String
    }

    private let items: [Item] = [
        Item(name: "Favorites",     symbol: "star.fill"),
        Item(name: "Photos",        symbol: "photo.fill"),
        Item(name: "Camera",        symbol: "camera.fill"),
        Item(name: "Messages",      symbol: "message.fill"),
        Item(name: "Mail",          symbol: "envelope.fill"),
        Item(name: "Maps",          symbol: "map.fill"),
        Item(name: "Music",         symbol: "music.note"),
        Item(name: "Settings",      symbol: "gearshape.fill"),
        Item(name: "Health",        symbol: "heart.fill"),
        Item(name: "Calendar",      symbol: "calendar"),
        Item(name: "Notes",         symbol: "note.text"),
        Item(name: "Reminders",     symbol: "checklist"),
    ]

    // MARK: - Views

    private let tableView = UITableView(frame: .zero, style: .insetGrouped)

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UITableView"
        view.backgroundColor = .systemGroupedBackground
        setupTableView()
    }

    // MARK: - Setup

    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(ItemCell.self, forCellReuseIdentifier: ItemCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

// MARK: - UITableViewDataSource

extension TableViewExampleViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.reuseIdentifier, for: indexPath) as! ItemCell
        cell.configure(with: items[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Tap any cell element to inspect it"
    }
}

// MARK: - ItemCell

private final class ItemCell: UITableViewCell {

    static let reuseIdentifier = "ItemCell"

    // MARK: - Views

    private let iconView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .systemBlue
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupViews() {
        contentView.addSubview(iconView)
        contentView.addSubview(nameLabel)

        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 28),
            iconView.heightAnchor.constraint(equalToConstant: 28),

            nameLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 14),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 52),
        ])
    }

    // MARK: - Configure

    func configure(with item: TableViewExampleViewController.Item) {
        iconView.image = UIImage(systemName: item.symbol)
        iconView.accessibilityIdentifier = item.symbol
        nameLabel.text = item.name
        nameLabel.accessibilityIdentifier = "label_\(item.name.lowercased())"
    }
}
