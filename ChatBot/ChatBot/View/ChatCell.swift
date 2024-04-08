//
//  ChatCell.swift
//  ChatBot
//
//  Created by 강창현 on 4/5/24.
//

import UIKit

final class ChatCell: UICollectionViewListCell {
  static var identifier: String {
    return String(describing: self)
  }
  
  private let userBubbleView = UserBubbleView()
  private let systemBubbleView = SystemBubbleView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
    setupUserConstraints()
    setupSystemConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureUser(text: String) {
    userBubbleView.isHidden = false
    userBubbleView.configureMessage(text: text)
  }
  
  func configureSystem(text: String) {
    systemBubbleView.isHidden = false
    systemBubbleView.configureMessage(text: text)
  }
}

private extension ChatCell {
  func configureUI() {
    systemBubbleView.translatesAutoresizingMaskIntoConstraints = false
    userBubbleView.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(userBubbleView)
    self.addSubview(systemBubbleView)
  }
  
  func setupUserConstraints() {
    NSLayoutConstraint.activate(
      [
        userBubbleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        userBubbleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
        userBubbleView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
      ]
    )
  }
  
  func setupSystemConstraints() {
    NSLayoutConstraint.activate(
      [
        systemBubbleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
        systemBubbleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
        systemBubbleView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
      ]
    )
  }
}
