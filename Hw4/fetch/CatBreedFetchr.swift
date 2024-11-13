//
//  CatBreedFetchr.swift
//  Hw4
//
//  Created by david david on 08.11.2024.
//

import Foundation
import Combine
class CatBreedFetcher {
    let catApi = CatAPIService()
    var cancellable = Set<AnyCancellable>()
    @Published var catBreeds: [CatBreed] = [] // Note: published means that each time catBreeds changes
    // all listeners will know about it. Just like with props in React
    var fetchBreeds: [Breed] = []
    func fetchBreeds(completion: @escaping () -> Void) {
        
         catApi.fetchCatBreeds().sink { _ in
        } receiveValue: { breeds in
            self.fetchBreeds = breeds
            DispatchQueue.main.async {
                completion()
            }
        }
        .store(in: &cancellable)
        
    }
    func fetchCatsForBreeds() {
            fetchBreeds {
                // https://swiftwithmajid.com/2021/05/12/combining-multiple-combine-publishers-in-swift/
                // here after fetching all the breeds we then try to fetch a cat for each breed.
                // We do that by creating publishers for each breed, we also create an object
                // CatBreed for each cat that combines breed info and cat image url. After all done we are 
                // Publisher MergeMany is used to combine all those publishers into one, then when
                // loading finished .collect() combies all CatBreed objects into the array
                let publishers = self.fetchBreeds.map { breed in
                    self.catApi.fetchCats(breedID: breed.id)
                        .compactMap { $0[0]}
                        .map { cat in
                                    CatBreed(
                                        id: cat.id,
                                        url: cat.url,
                                        name: breed.name
                                    )
                                }
                        .eraseToAnyPublisher()
                } // This code produces publishers (they are mostly like promises in JavaScript), all
                // these publishers are making request to fetch cat object for each breed
                
                Publishers.MergeMany(publishers)
                    .collect()
                    .sink(receiveCompletion: { completionStatus in
                        if case .failure(let error) = completionStatus {
                            print("Error fetching cat images:", error)
                        }
                    }, receiveValue: { catBreeds in
                        self.catBreeds = catBreeds  
                    })
                    .store(in: &self.cancellable) // this code merges all publishers
            }
        }
}
