//
//  SwiftUI+View.swift
//  DummyApp
//
//  Created by Anton Martsenyuk on 02.10.2020.
//  Copyright © 2020 Anton Martsenyuk. All rights reserved.
//

import SwiftUI

extension View {
    func eraseToAnyView() -> AnyView { AnyView(self) }
}
