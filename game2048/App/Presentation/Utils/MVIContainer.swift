//
//  MVIContainer.swift
//  game2048
//
//  Created by sw on 2023/09/03.
//

import Combine
import SwiftUI

final class MVIContainer<Intent, Model>: ObservableObject {

    // MARK: Public

    let intent: Intent
    var model: Model

    // MARK: private

    private var cancellable: Set<AnyCancellable> = []

    // MARK: Life cycle

    init(intent: Intent, model: Model, modelChangePublisher: ObjectWillChangePublisher) {
        self.intent = intent
        self.model = model

        modelChangePublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: objectWillChange.send)
            .store(in: &cancellable)
    }
}
