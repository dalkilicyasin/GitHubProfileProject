//
//  ContentView.swift
//  async-await-githup
//
//  Created by yasin on 26.11.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var user: GitHubUser?
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: user?.avatarUrl ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .foregroundColor(.secondary)
            }
            .frame(width: 120, height: 120)

            Text(user?.login ?? "")
                .bold()
                .font(.title3)
            Text(user?.bio ?? "")
                .padding()
        }
        .padding()
        .task {
            do {
                user = try await  NetworkManager.shared.getUser()
            } catch GHError.invalidURL {
                print("invalid URL")
            } catch GHError.invalidResponse {
                print("invalid Response")
            } catch GHError.invalidData {
                print("invalid Data")
            } catch {
                print("unknown")
            }
        }
    }
}

#Preview {
    ContentView()
}
