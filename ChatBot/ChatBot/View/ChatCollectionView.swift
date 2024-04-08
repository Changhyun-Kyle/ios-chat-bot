//
//  ChatCollectionView.swift
//  ChatBot
//
//  Created by 강창현 on 4/5/24.
//

import UIKit

final class ChatCollectionView: UICollectionView {
  
  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: layout)
    setupChatCell()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension ChatCollectionView {
  func setupChatCell() {
    self.register(ChatCell.self, forCellWithReuseIdentifier: ChatCell.identifier)
  }
}
