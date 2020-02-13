//
//  Interactor.swift
//  RandomUser
//
//  Created by Vincent Lemonnier on 11/02/2020.
//  Copyright © 2020 Vincent Lemonnier. All rights reserved.
//

import RxSwift

open class Interactor<T, Params> {
    
    fileprivate let backgroundScheduler = ConcurrentDispatchQueueScheduler(qos: .background)
    fileprivate let foregroundScheduler = MainScheduler()
    private let disposableBag = DisposeBag()
    fileprivate var disposable: Disposable? {
        didSet {
            disposable?.disposed(by: disposableBag)
        }
    }
    
    public typealias ResultHandler = (Result<T>) -> Void
    
    public func run(params: Params, handler: @escaping ResultHandler) { fatalError("Abstract method") }
    
    func cancel() {
        disposable?.dispose()
    }
    
    func single<R>(_ block: @escaping () throws -> R) -> Single<R> {
        return Single<R>.create { single in
            do {
                single(.success(try block()))
            } catch {
                single(.error(error))
            }
            return Disposables.create()
        }
    }
    
}

extension Interactor where Params == Void {
    
    public func run(handler: @escaping ResultHandler) {
        self.run(params: (), handler: handler)
    }
    
}

open class CompletableInteractor<T, Params>: Interactor<T, Params> {
    
    func buildSingle(params: Params) -> Single<T> {
        fatalError("Abstract method")
    }
    
    public override func run(params: Params, handler: @escaping ResultHandler) {
        cancel()
        disposable = buildSingle(params: params)
            .subscribeOn(backgroundScheduler)
            .observeOn(foregroundScheduler)
            .subscribe(
                onSuccess: {
                    handler(.success($0))
            }, onError: { error in
                handler(.failure(error))
            })
    }
    
}

open class StreamableInteractor<T, Params>: Interactor<T, Params> {
    
    internal func buildStream(params: Params) -> Observable<T> {
        fatalError("Abstract method")
    }
    
    public override func run(params: Params, handler: @escaping ResultHandler) {
        cancel()
        disposable = buildStream(params: params)
            .observeOn(foregroundScheduler)
            .subscribe(onNext: { handler(.newValue($0)) }, onError: { error in
                handler(.failure(error))
            }, onCompleted: { handler(.terminated(nil)) }, onDisposed: { handler(.canceled) })
    }
    
}
