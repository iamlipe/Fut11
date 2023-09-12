//
//  SelectTeamView.swift
//  Fut11
//
//  Created by Felipe Lima on 12/09/23.
//

import SwiftUI

struct SelectTeamView: View {
    var body: some View {
        NavigationView {
            NavigationLink("Go To Field", destination: FieldView())
        }
    }
}

struct SelectTeamView_Previews: PreviewProvider {
    static var previews: some View {
        SelectTeamView()
    }
}
