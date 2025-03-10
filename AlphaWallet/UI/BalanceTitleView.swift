// Copyright SIX DAY LLC. All rights reserved.

import UIKit

enum BalanceMode {
    case short
    case full
}

class BalanceTitleView: UIView {
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private var mode = BalanceMode.short

    @objc dynamic var titleTextColor: UIColor? {
        get { return titleLabel.textColor }
        set { titleLabel.textColor = newValue }
    }

    @objc dynamic var subTitleTextColor: UIColor? {
        get { return subTitleLabel.textColor }
        set { subTitleLabel.textColor = newValue }
    }

    var viewModel: BalanceBaseViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            configure(viewModel: viewModel)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontSizeToFitWidth = true

        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.textAlignment = .center
        subTitleLabel.adjustsFontSizeToFitWidth = true

        let stackView = [
            titleLabel,
            subTitleLabel,
        ].asStackView(axis: .vertical, spacing: 2)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.anchorsConstraint(to: self),
        ])

        stackView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(switchModel))
        )
    }

    private func configure(viewModel: BalanceBaseViewModel) {
        titleLabel.font = Fonts.semibold(size: 18)
        subTitleLabel.font = Fonts.regular(size: 14)

        let amount: String
        switch mode {
        case .full:
            amount = viewModel.amountFull
        case .short:
            amount = viewModel.amountShort
        }

        titleLabel.text = "\(amount) \(viewModel.symbol)"
        subTitleLabel.text = viewModel.currencyAmount
    }

    @objc func switchModel() {
        switch mode {
        case .full:
            mode = .short
        case .short:
            mode = .full
        }

        guard let viewModel = viewModel else { return }
        configure(viewModel: viewModel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BalanceTitleView {
    static func make(from session: WalletSession, _ transferType: TransferType) -> BalanceTitleView {
        let view = BalanceTitleView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        switch transferType {
        case .nativeCryptocurrency, .dapp:
            session.balanceViewModel.subscribe { [weak view] viewModel in
                guard let viewModel = viewModel else { return }
                view?.viewModel = viewModel
            }
        case .ERC20Token(let token, _, _):
            view.viewModel = BalanceTokenViewModel(token: token)
        case .ERC875Token(let token):
            view.viewModel = BalanceTokenViewModel(token: token)
        case .ERC875TokenOrder: break
        case .ERC721Token(let token):
            view.viewModel = BalanceTokenViewModel(token: token)
        }
        session.refresh(.ethBalance)
        return view
    }
}
