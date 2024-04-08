//
//  ChatCollectionViewDataSource.swift
//  ChatBot
//
//  Created by 강창현 on 4/5/24.
//

import UIKit

enum MessageSection {
  case messages
}

typealias ChatCollectionViewSnapshot = NSDiffableDataSourceSnapshot<MessageSection, Message>

final class ChatCollectionViewDataSource: UICollectionViewDiffableDataSource<MessageSection, Message> {
  static let cellProvider: CellProvider = { collectionView, indexPath, message in
    guard
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatCell.identifier, for: indexPath) as? ChatCell
    else {
      return ChatCell()
    }
    message.role == "user" ? cell.configureUser(text: message.content) : cell.configureSystem(text: message.content)
    return cell
  }
  
  convenience init(collectionView: ChatCollectionView) {
    self.init(collectionView: collectionView, cellProvider: Self.cellProvider)
  }
}
