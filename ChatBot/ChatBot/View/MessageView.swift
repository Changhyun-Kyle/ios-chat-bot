//
//  MessageView.swift
//  ChatBot
//
//  Created by 이보한 on 2024/4/4.
//

import UIKit

final class MessageView: UILabel {
  private var width: Double = 0.0
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func drawText(in rect: CGRect) {
    let insets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
    super.drawText(in: rect.inset(by: insets))
  }
  
  func setupSize() {
    guard let text = self.text as? NSString else { return }
    
    width = text.size(
      withAttributes: [
        NSAttributedString.Key.font : self.font ?? .preferredFont(forTextStyle: .body)
      ]
    ).width
    
    if width >= UIScreen.main.bounds.width * 0.75 {
      width = UIScreen.main.bounds.width * 0.75
    }
    setupConstraints()
  }
}

private extension MessageView {
  func configureUI() {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.backgroundColor = .clear
    self.textAlignment = .left
    self.numberOfLines = 0
  }
  
  
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      self.widthAnchor.constraint(equalToConstant: width),
    ])
  }
}
