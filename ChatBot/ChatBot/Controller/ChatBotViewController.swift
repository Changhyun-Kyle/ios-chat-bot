//
//  ViewController.swift
//  ChatBot
//
//  Created by Tacocat on 1/1/24.
//

import UIKit
import Combine

final class ChatBotViewController: UIViewController {
  private lazy var chatCollectionView: ChatCollectionView = {
    let configure = UICollectionLayoutListConfiguration(appearance: .plain)
    let layout = UICollectionViewCompositionalLayout.list(using: configure)
    let collectionView = ChatCollectionView(frame: .zero, collectionViewLayout: layout)
    return collectionView
  }()
  private lazy var dataSource = ChatCollectionViewDataSource(collectionView: chatCollectionView)
  private let chatBotViewModel: ChatViewModel = .init()
  private var cancellable = Set<AnyCancellable>()
  private let input: PassthroughSubject<ChatViewModel.Input, Never> = .init()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupCollectionView()
    configureUI()
    setupConstraints()
    bind()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    input.send(
      .sendButtonTapped(
        message: Message(
          role: "user",
          content: "Compose a poem that explains the concept of recursion in programming."
        )
      )
    )
  }
}

private extension ChatBotViewController {
  func configureUI() {
    view.addSubview(chatCollectionView)
  }
  
  func setupCollectionView() {
    self.chatCollectionView.dataSource = dataSource
  }
  
  func setupConstraints() {
    chatCollectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate(
      [
        chatCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        chatCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        chatCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        chatCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
      ]
    )
  }
  
  func bind() {
    let output = chatBotViewModel.transform(
      input: input.eraseToAnyPublisher()
    )
    output.sink { [weak self] event in
      switch event {
      case .fetchChatResponseDidFail(let error):
        print(error.localizedDescription)
      case .fetchChatResponseDidSucceed(let response):
        self?.applyChatResponse(response: response)
      case .toggleSendButton(let isEnable):
        print("\(isEnable)")
      }
    }
    .store(in: &cancellable)
  }
  
  func applyChatResponse(response: RequestModel) {
    var chatCollectionViewSnapshot = ChatCollectionViewSnapshot()
    chatCollectionViewSnapshot.appendSections([.messages])
    chatCollectionViewSnapshot.appendItems(response.messages)
    dataSource.apply(chatCollectionViewSnapshot)
  }
}
