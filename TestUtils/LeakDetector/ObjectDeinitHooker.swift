//
//  ObjectDeinitHooker.swift
//  TestUtils
//
//  Created by Hoang Nguyen on 18/9/23.
//


import Foundation

fileprivate var deinitCallbackKey = "deinitCallbackKey"

/// Hook callbacks into object's deinit function
enum ObjectDeinitHooker {
  /// hook on object deinit call.
  /// - Parameter forObject: the object to be hooked.
  /// - Parameter callback: the closure which wil be called when deinit is called on the object.
  static func hook(forObject object: AnyObject,
                   callback: @escaping () -> Void) {
    let callbacksHolder = getDeinitCallbacksHolder(forObject: object)
    callbacksHolder.addCallback(callback)
  }

  static fileprivate func getDeinitCallbacksHolder(forObject object: AnyObject) -> DeinitCallbacksHolder {
    if let deinitCallback = objc_getAssociatedObject(object, &deinitCallbackKey) as? DeinitCallbacksHolder {
      return deinitCallback
    } else {
      let deinitCallback = DeinitCallbacksHolder()
      objc_setAssociatedObject(object, &deinitCallbackKey, deinitCallback, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      return deinitCallback
    }
  }
}

@objc fileprivate class DeinitCallbacksHolder: NSObject {
  private var callbacks: [() -> Void] = []

  func addCallback(_ callback: @escaping () -> Void) {
    callbacks.append(callback)
  }

  deinit {
    callbacks.forEach({ $0() })
  }
}
