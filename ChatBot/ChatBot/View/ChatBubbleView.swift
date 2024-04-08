//
//  ChatBubbleView.swift
//  Swift_CoreGraphics
//
//  Created by 강창현 on 4/4/24.
//

import UIKit

final class UserBubbleView: ChatBubbleView {
  private var bezierPath: UIBezierPath?
  
  override func draw(_ rect: CGRect) {
    guard
      bezierPath != nil
    else {
      let bezierPath = UIBezierPath()
      self.bezierPath = bezierPath
      setRightBubbleView(rect: rect, bezierPath: bezierPath)
      bezierPath.close()
      backgroundColor?.setFill()
      bezierPath.fill()
      return
    }
  }
}

final class SystemBubbleView: ChatBubbleView {
  private var bezierPath: UIBezierPath?
  
  override func draw(_ rect: CGRect) {
    guard 
      bezierPath != nil
    else {
      let bezierPath = UIBezierPath()
      self.bezierPath = bezierPath
      setLeftBubbleView(rect: rect, bezierPath: bezierPath)
      bezierPath.close()
      backgroundColor?.setFill()
      bezierPath.fill()
      return
    }
  }
}

class ChatBubbleView: UIView {
  private let messageView = MessageView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .clear
    self.configureUI()
    self.setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureMessage(text: String) {
    messageView.text = text
    messageView.setupSize()
  }
}

private extension ChatBubbleView {
  func configureUI() {
    self.addSubview(messageView)
    messageView.translatesAutoresizingMaskIntoConstraints = false
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate(
      [
        self.widthAnchor.constraint(equalTo: messageView.widthAnchor, constant: 20),
        self.heightAnchor.constraint(equalTo: messageView.heightAnchor, constant: 15),
        messageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        messageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      ]
    )
  }
  
  func setRightBubbleView(rect: CGRect,bezierPath: UIBezierPath) {
    self.backgroundColor = .systemBlue
    messageView.textColor = .white
    let bottom = rect.height
    let right = rect.width
    
    bezierPath.move(
      to: CGPoint(x: right - 22, y: bottom)
    )
    bezierPath.addLine(
      to: CGPoint(x: 17, y: bottom)
    )
    bezierPath.addCurve(
      to: CGPoint(x: 0, y: bottom - 18),
      controlPoint1: CGPoint(x: 7.61, y: bottom),
      controlPoint2: CGPoint(x: 0, y: bottom - 7.61)
    )
    bezierPath.addLine(
      to: CGPoint(x: 0, y: 17)
    )
    bezierPath.addCurve(
      to: CGPoint(x: 17, y: 0),
      controlPoint1: CGPoint(x: 0, y: 7.61),
      controlPoint2: CGPoint(x: 7.61, y: 0)
    )
    bezierPath.addLine(
      to: CGPoint(x: right - 21, y: 0)
    )
    bezierPath.addCurve(
      to: CGPoint(x: right - 4, y: 17),
      controlPoint1: CGPoint(x: right - 11.61, y: 0),
      controlPoint2: CGPoint(x: right - 4, y: 7.61)
    )
    bezierPath.addLine(
      to: CGPoint(x: right - 4, y: bottom - 11)
    )
    bezierPath.addCurve(
      to: CGPoint(x: right, y: bottom),
      controlPoint1: CGPoint(x: right - 4, y: bottom - 1),
      controlPoint2: CGPoint(x: right, y: bottom)
    )
    bezierPath.addLine(
      to: CGPoint(x: right + 0.05, y: bottom - 0.01)
    )
    bezierPath.addCurve(
      to: CGPoint(x: right - 11.04, y: bottom - 4.04),
      controlPoint1: CGPoint(x: right - 4.07, y: bottom + 0.43),
      controlPoint2: CGPoint(x: right - 8.16, y: bottom - 1.06)
    )
    bezierPath.addCurve(
      to: CGPoint(x: right - 22, y: bottom),
      controlPoint1: CGPoint(x: right - 16, y: bottom),
      controlPoint2: CGPoint(x: right - 19, y: bottom)
    )
    
  }
  
  func setLeftBubbleView(rect: CGRect, bezierPath: UIBezierPath) {
    self.backgroundColor = .systemGray5
    let bottom = rect.height
    let right = rect.width
    
    bezierPath.move(
      to: CGPoint(x: 22, y: bottom)
    )
    bezierPath.addLine(
      to: CGPoint(x: right - 17, y: bottom)
    )
    bezierPath.addCurve(
      to: CGPoint(x: right, y: bottom - 18),
      controlPoint1: CGPoint(x: right - 7.61, y: bottom),
      controlPoint2: CGPoint(x: right, y: bottom - 7.61)
    )
    bezierPath.addLine(
      to: CGPoint(x: right, y: 17)
    )
    bezierPath.addCurve(
      to: CGPoint(x: right - 17, y: 0),
      controlPoint1: CGPoint(x: right, y: 7.61),
      controlPoint2: CGPoint(x: right - 7.61, y: 0)
    )
    bezierPath.addLine(
      to: CGPoint(x: 21, y: 0)
    )
    bezierPath.addCurve(
      to: CGPoint(x: 4, y: 17),
      controlPoint1: CGPoint(x: 11.61, y: 0),
      controlPoint2: CGPoint(x: 4, y: 7.61)
    )
    bezierPath.addLine(
      to: CGPoint(x: 4, y: bottom - 11)
    )
    bezierPath.addCurve(
      to: CGPoint(x: 0, y: bottom),
      controlPoint1: CGPoint(x: 4, y: bottom - 1),
      controlPoint2: CGPoint(x: 0, y: bottom)
    )
    bezierPath.addLine(
      to: CGPoint(x: -0.05, y: bottom - 0.01)
    )
    bezierPath.addCurve(
      to: CGPoint(x: 11.04, y: bottom - 4.04),
      controlPoint1: CGPoint(x: 4.07, y: bottom + 0.43),
      controlPoint2: CGPoint(x: 8.16, y: bottom - 1.06)
    )
    bezierPath.addCurve(
      to: CGPoint(x: 22, y: bottom),
      controlPoint1: CGPoint(x: 16, y: bottom),
      controlPoint2: CGPoint(x: 19, y: bottom)
    )
  }
}
