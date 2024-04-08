//
//  SceneDelegate.swift
//  ChatBot
//
//  Created by Tacocat on 1/1/24.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = ChatBotViewController()
    window?.makeKeyAndVisible()
  }
}
