//
//  DetailGameMapper.swift
//  Gametopia
//
//  Created by Patricia Fiona on 20/11/22.
//

import Foundation
import RealmSwift

final class DetailGameMapper {
  
  static func mapDetailGameResponsesToEntities(
    input detailResponse: DetailGameResponse
  ) -> GameEntity {
    let result = detailResponse
    let newDetailGame = GameEntity()
    
    newDetailGame.id = result.id ?? 0
    newDetailGame.isFavorite = false //default for first store
    newDetailGame.name = result.name ?? "Unknown Name"
    newDetailGame.name_original = result.name_original ?? "Unknown Original Name"
    newDetailGame.slug = result.slug ?? "Unknown Slug"
    newDetailGame.desc = result.description ?? "No description"
    newDetailGame.released = result.released ?? "Unknown released"
    newDetailGame.updated = result.updated ?? "Unknown updated"
    newDetailGame.background_image = result.background_image ?? ""
    newDetailGame.background_image_additional = result.background_image_additional ?? ""
    newDetailGame.website = result.website ?? ""
    newDetailGame.rating = result.rating ?? 0.0
    newDetailGame.added = result.added ?? 0
    newDetailGame.playtime = result.playtime ?? 0
    newDetailGame.achievements_count = result.achievements_count ?? 0
    newDetailGame.ratings_count = result.ratings_count ?? 0
    newDetailGame.suggestions_count = result.suggestions_count ?? 0
    newDetailGame.reviews_count = result.reviews_count ?? 0
    newDetailGame.description_raw = result.description_raw ?? ""
    
    //parent platforms
    let temp = List<PlatformEntity>()
    for platform in result.parent_platforms! {
      let platformTemp = PlatformEntity()
      platformTemp.id = UUID()
      platformTemp.slug = platform.platform.slug ?? "Unknown Slug"
      platformTemp.name = platform.platform.name ?? "Unknown Name"
      
      temp.append(
        platformTemp
      )
    }
    newDetailGame.parent_platforms = temp
    
    // Platforms
    let temp01 = List<DetailPlatformEntity>()
    for platform in result.platforms! {
      let platformTemp = DetailPlatformEntity()
      
      //Platform detail
      let platformDetailTemp = PlatformDetailsEntity()
      platformDetailTemp.id = UUID()
      platformDetailTemp.name = platform.platform?.name ?? "Unknown name"
      platformDetailTemp.slug = platform.platform?.slug ?? "Unknown slug"
      platformDetailTemp.games_count = platform.platform?.games_count ?? 0
      platformDetailTemp.image = platform.platform?.image ?? ""
      platformDetailTemp.image_background = platform.platform?.image_background ?? ""
      platformDetailTemp.year_end = platform.platform?.year_end ?? 0
      platformDetailTemp.year_start = platform.platform?.year_start ?? 0
      
      //Platform requirement
      let platfromRequrementTemp = PlatformRequirementEntity()
      platfromRequrementTemp.minimum = platform.requirements?.minimum ?? ""
      
      //add to DetailPlatformEntity
      platformTemp.platform = platformDetailTemp
      platformTemp.released_at = platform.released_at ?? "Unknown release"
      platformTemp.requirements = platfromRequrementTemp
      
      temp01.append(
        platformTemp
      )
    }
    newDetailGame.platforms = temp01
    
    //StoreDetailsEntity
    let temp02 = List<StoreDetailsEntity>()
    for store in result.stores!{
      let storeTemp = StoreDetailsEntity()
      
      let storeEntity = StoreEntity()
      storeEntity.id = UUID()
      storeEntity.name = store.store?.name ?? "Unknown name"
      storeEntity.slug = store.store?.slug ?? "Unknown slug"
      storeEntity.games_count = store.store?.games_count ?? 0
      storeEntity.domain = store.store?.domain ?? "Unknown domain"
      storeEntity.image_background = store.store?.image_background ?? ""
      
      storeTemp.id =  UUID()
      storeTemp.url = store.url ?? ""
      storeTemp.store = storeEntity
      
      temp02.append(storeTemp)
    }
    
    newDetailGame.stores = temp02
    
    //DeveloperInDetailsEntity
    let temp03 = List<DeveloperInDetailsEntity>()
    for developer in result.developers!{
      let developerInDetailsEntity = DeveloperInDetailsEntity()
      developerInDetailsEntity.id = UUID()
      developerInDetailsEntity.name = developer.name ?? "Unknown name"
      developerInDetailsEntity.slug = developer.slug ?? "Unknown slug"
      developerInDetailsEntity.games_count = developer.games_count ?? 0
      developerInDetailsEntity.image_background = developer.image_background ?? ""
      
      temp03.append(developerInDetailsEntity)
    }
    
    newDetailGame.developers = temp03
    
    //GenreInDetailsEntity
    let temp04 = List<GenreInDetailsEntity>()
    for genre in result.genres!{
      let genreInDetailsEntity = GenreInDetailsEntity()
      genreInDetailsEntity.id = UUID()
      genreInDetailsEntity.name = genre.name ?? "Unknown name"
      genreInDetailsEntity.slug = genre.slug ?? "Unknown slug"
      genreInDetailsEntity.games_count = genre.games_count ?? 0
      genreInDetailsEntity.image_background = genre.image_background ?? ""
      
      temp04.append(genreInDetailsEntity)
    }
    
    newDetailGame.genres = temp04
    
    //TagEntity
    let temp05 = List<TagEntity>()
    for tag in result.tags! {
      let tagEntity = TagEntity()
      tagEntity.id = UUID()
      tagEntity.name = tag.name ?? "Unknown name"
      tagEntity.slug = tag.slug ?? "Unknown slug"
      tagEntity.games_count = tag.games_count ?? 0
      tagEntity.image_background = tag.image_background ?? ""
      
      temp05.append(tagEntity)
    }
    
    newDetailGame.tags = temp05
    
    //PublisherEntity
    let temp06 = List<PublisherEntity>()
    for publisher in result.publishers! {
      let publisherEntity = PublisherEntity()
      publisherEntity.id =  UUID()
      publisherEntity.name = publisher.name ?? "Unknown name"
      publisherEntity.slug = publisher.slug ?? "Unknown slug"
      publisherEntity.games_count = publisher.games_count ?? 0
      publisherEntity.image_background = publisher.image_background ?? ""
      
      temp06.append(publisherEntity)
    }
    
    newDetailGame.publishers = temp06
    
    return newDetailGame
  }
  
  static func mapDetailGameResponsesToEntities(
    input detailResponse: [DetailGameResponse]
  ) -> [GameEntity] {
    return detailResponse.map { result in
      let newDetailGame = GameEntity()
      
      newDetailGame.id = result.id ?? 0
      newDetailGame.isFavorite = false //default for first store
      newDetailGame.name = result.name ?? "Unknown Name"
      newDetailGame.name_original = result.name_original ?? "Unknown Original Name"
      newDetailGame.slug = result.slug ?? "Unknown Slug"
      newDetailGame.desc = result.description ?? "No description"
      newDetailGame.released = result.released ?? "Unknown released"
      newDetailGame.updated = result.updated ?? "Unknown updated"
      newDetailGame.background_image = result.background_image ?? ""
      newDetailGame.background_image_additional = result.background_image_additional ?? ""
      newDetailGame.website = result.website ?? ""
      newDetailGame.rating = result.rating ?? 0.0
      newDetailGame.added = result.added ?? 0
      newDetailGame.playtime = result.playtime ?? 0
      newDetailGame.achievements_count = result.achievements_count ?? 0
      newDetailGame.ratings_count = result.ratings_count ?? 0
      newDetailGame.suggestions_count = result.suggestions_count ?? 0
      newDetailGame.reviews_count = result.reviews_count ?? 0
      newDetailGame.description_raw = result.description_raw ?? ""
      
      //parent platforms
      let temp = List<PlatformEntity>()
      for platform in result.parent_platforms! {
        let platformTemp = PlatformEntity()
        platformTemp.id = UUID()
        platformTemp.slug = platform.platform.slug ?? "Unknown Slug"
        platformTemp.name = platform.platform.name ?? "Unknown Name"
        
        temp.append(
          platformTemp
        )
      }
      newDetailGame.parent_platforms = temp
      
      // Platforms
      let temp01 = List<DetailPlatformEntity>()
      for platform in result.platforms! {
        let platformTemp = DetailPlatformEntity()
        
        //Platform detail
        let platformDetailTemp = PlatformDetailsEntity()
        platformDetailTemp.id = UUID()
        platformDetailTemp.name = platform.platform?.name ?? "Unknown name"
        platformDetailTemp.slug = platform.platform?.slug ?? "Unknown slug"
        platformDetailTemp.games_count = platform.platform?.games_count ?? 0
        platformDetailTemp.image = platform.platform?.image ?? ""
        platformDetailTemp.image_background = platform.platform?.image_background ?? ""
        platformDetailTemp.year_end = platform.platform?.year_end ?? 0
        platformDetailTemp.year_start = platform.platform?.year_start ?? 0
        
        //Platform requirement
        let platfromRequrementTemp = PlatformRequirementEntity()
        platfromRequrementTemp.minimum = platform.requirements?.minimum ?? ""
        
        //add to DetailPlatformEntity
        platformTemp.platform = platformDetailTemp
        platformTemp.released_at = platform.released_at ?? "Unknown release"
        platformTemp.requirements = platfromRequrementTemp
        
        temp01.append(
          platformTemp
        )
      }
      newDetailGame.platforms = temp01
      
      //StoreDetailsEntity
      let temp02 = List<StoreDetailsEntity>()
      for store in result.stores!{
        let storeTemp = StoreDetailsEntity()
        
        let storeEntity = StoreEntity()
        storeEntity.id = UUID()
        storeEntity.name = store.store?.name ?? "Unknown name"
        storeEntity.slug = store.store?.slug ?? "Unknown slug"
        storeEntity.games_count = store.store?.games_count ?? 0
        storeEntity.domain = store.store?.domain ?? "Unknown domain"
        storeEntity.image_background = store.store?.image_background ?? ""
        
        storeTemp.id = UUID()
        storeTemp.url = store.url ?? ""
        storeTemp.store = storeEntity
        
        temp02.append(storeTemp)
      }
      
      newDetailGame.stores = temp02
      
      //DeveloperInDetailsEntity
      let temp03 = List<DeveloperInDetailsEntity>()
      for developer in result.developers!{
        let developerInDetailsEntity = DeveloperInDetailsEntity()
        developerInDetailsEntity.id = UUID()
        developerInDetailsEntity.name = developer.name ?? "Unknown name"
        developerInDetailsEntity.slug = developer.slug ?? "Unknown slug"
        developerInDetailsEntity.games_count = developer.games_count ?? 0
        developerInDetailsEntity.image_background = developer.image_background ?? ""
        
        temp03.append(developerInDetailsEntity)
      }
      
      newDetailGame.developers = temp03
      
      //GenreInDetailsEntity
      let temp04 = List<GenreInDetailsEntity>()
      for genre in result.genres!{
        let genreInDetailsEntity = GenreInDetailsEntity()
        genreInDetailsEntity.id = UUID()
        genreInDetailsEntity.name = genre.name ?? "Unknown name"
        genreInDetailsEntity.slug = genre.slug ?? "Unknown slug"
        genreInDetailsEntity.games_count = genre.games_count ?? 0
        genreInDetailsEntity.image_background = genre.image_background ?? ""
        
        temp04.append(genreInDetailsEntity)
      }
      
      newDetailGame.genres = temp04
      
      //TagEntity
      let temp05 = List<TagEntity>()
      for tag in result.tags! {
        let tagEntity = TagEntity()
        tagEntity.id = UUID()
        tagEntity.name = tag.name ?? "Unknown name"
        tagEntity.slug = tag.slug ?? "Unknown slug"
        tagEntity.games_count = tag.games_count ?? 0
        tagEntity.image_background = tag.image_background ?? ""
        
        temp05.append(tagEntity)
      }
      
      newDetailGame.tags = temp05
      
      //PublisherEntity
      let temp06 = List<PublisherEntity>()
      for publisher in result.publishers! {
        let publisherEntity = PublisherEntity()
        publisherEntity.id = UUID()
        publisherEntity.name = publisher.name ?? "Unknown name"
        publisherEntity.slug = publisher.slug ?? "Unknown slug"
        publisherEntity.games_count = publisher.games_count ?? 0
        publisherEntity.image_background = publisher.image_background ?? ""
        
        temp06.append(publisherEntity)
      }
      
      newDetailGame.publishers = temp06
      
      return newDetailGame
    }
  }
  
  static func mapDetailGameResponseToEntities(
    input gameResult: [GameResult]
  ) -> [GameEntity] {
    return gameResult.map { result in
      let newDetailGame = GameEntity()
      
      newDetailGame.id = result.id ?? 0
      newDetailGame.isFavorite = false //default for first store
      newDetailGame.name = result.name ?? "Unknown Name"
      newDetailGame.released = result.released ?? "Unknown released"
      newDetailGame.background_image = result.background_image ?? ""
      newDetailGame.rating = result.rating ?? 0.0
      newDetailGame.suggestions_count = result.suggestions_count ?? 0
      newDetailGame.reviews_count = result.reviews_count ?? 0
      newDetailGame.updated = result.updated ?? "Unknown updated"
      
      return newDetailGame
    }
  }

  static func mapDetailGameEntitiesToDomains(
    input detailGameEntities: [GameEntity]
  ) -> [DetailGameModel] {
    return detailGameEntities.map { result in
      return DetailGameModel(
        id: Int(result.id),
        isFavorite: result.isFavorite,
        slug: result.slug,
        name: result.name,
        nameOriginal: result.name_original,
        description: result.desc,
        released: result.released,
        updated: result.updated,
        backgroundImage: result.background_image,
        backgroundImageAdditional: result.background_image_additional,
        website: result.website,
        rating: result.rating,
        added: result.added,
        playtime: result.playtime,
        achievementsCount: result.ratings_count,
        ratingsCount: result.reviews_count,
        suggestionsCount: result.suggestions_count,
        reviewsCount: result.achievements_count,
        parentPlatforms: result.parent_platforms.map { platform in
          return PlatformModel(
            id: platform.id,
            name: platform.name,
            slug: platform.slug
          )
        },
        platforms: result.platforms.map { data in
          return DetailPlatformModel(
            id: data.id,
            platform: PlatformDetailsModel(
              id: data.platform!.id,
              name: data.platform?.name,
              slug: data.platform?.slug,
              image: data.platform?.image,
              yearEnd: data.platform?.year_end,
              yearStart: data.platform?.year_start,
              gamesCount: data.platform?.games_count,
              imageBackground: data.platform?.image_background
            ),
            releasedAt: data.released_at,
            requirements: PlatformRequirementModel(
              id: data.requirements!.id,
              minimum: data.requirements?.minimum
            )
          )
        },
        stores: result.stores.map { store in
           return StoreDetailsModel(
            id: store.id,
            url: store.url,
            store: StoreModel(
              id: store.store!.id,
              name: store.store?.name,
              slug: store.store?.slug,
              gamesCount: store.store?.games_count,
              domain: store.store?.domain,
              imageBackground: store.store?.image_background
            )
           )
        },
        developers: result.developers.map { developer in
          return DeveloperInDetailGameModel(
            id: developer.id,
            name: developer.name,
            slug: developer.slug,
            gamesCount: developer.games_count,
            imageBackground: developer.image_background
          )
        },
        genres: result.genres.map { genre in
          return GenreInDetailsModel(
            id: genre.id,
            name: genre.name,
            slug: genre.slug,
            gamesCount: genre.games_count,
            imageBackground: genre.image_background
          )
        },
        tags: result.tags.map { tag in
          return TagModel(
            id: tag.id,
            name: tag.name,
            slug: tag.slug,
            gamesCount: tag.games_count,
            imageBackground: tag.image_background
          )
        },
        publishers: result.publishers.map { publisher in
          return PublisherModel(
            id: publisher.id,
            name: publisher.name,
            slug: publisher.slug,
            gamesCount: publisher.games_count,
            imageBackground: publisher.image_background
          )
        },
        descriptionRaw: result.description_raw
      )
    }
  }
  
  static func mapDetailGameEntityToDomain(
    input result: GameEntity
  ) -> DetailGameModel {
    return DetailGameModel(
      id: Int(result.id),
      isFavorite: result.isFavorite,
      slug: result.slug,
      name: result.name,
      nameOriginal: result.name_original,
      description: result.desc,
      released: result.released,
      updated: result.updated,
      backgroundImage: result.background_image,
      backgroundImageAdditional: result.background_image_additional,
      website: result.website,
      rating: result.rating,
      added: result.added,
      playtime: result.playtime,
      achievementsCount: result.ratings_count,
      ratingsCount: result.reviews_count,
      suggestionsCount: result.suggestions_count,
      reviewsCount: result.achievements_count,
      parentPlatforms: result.parent_platforms.map { platform in
        return PlatformModel(
          id: platform.id,
          name: platform.name,
          slug: platform.slug
        )
      },
      platforms: result.platforms.map { data in
        return DetailPlatformModel(
          id: data.id,
          platform: PlatformDetailsModel(
            id: data.platform!.id,
            name: data.platform?.name,
            slug: data.platform?.slug,
            image: data.platform?.image,
            yearEnd: data.platform?.year_end,
            yearStart: data.platform?.year_start,
            gamesCount: data.platform?.games_count,
            imageBackground: data.platform?.image_background
          ),
          releasedAt: data.released_at,
          requirements: PlatformRequirementModel(
            id: data.requirements!.id,
            minimum: data.requirements?.minimum
          )
        )
      },
      stores: result.stores.map { store in
         return StoreDetailsModel(
          id: store.id,
          url: store.url,
          store: StoreModel(
            id: store.store!.id,
            name: store.store?.name,
            slug: store.store?.slug,
            gamesCount: store.store?.games_count,
            domain: store.store?.domain,
            imageBackground: store.store?.image_background
          )
         )
      },
      developers: result.developers.map { developer in
        return DeveloperInDetailGameModel(
          id: developer.id,
          name: developer.name,
          slug: developer.slug,
          gamesCount: developer.games_count,
          imageBackground: developer.image_background
        )
      },
      genres: result.genres.map { genre in
        return GenreInDetailsModel(
          id: genre.id,
          name: genre.name,
          slug: genre.slug,
          gamesCount: genre.games_count,
          imageBackground: genre.image_background
        )
      },
      tags: result.tags.map { tag in
        return TagModel(
          id: tag.id,
          name: tag.name,
          slug: tag.slug,
          gamesCount: tag.games_count,
          imageBackground: tag.image_background
        )
      },
      publishers: result.publishers.map { publisher in
        return PublisherModel(
          id: publisher.id,
          name: publisher.name,
          slug: publisher.slug,
          gamesCount: publisher.games_count,
          imageBackground: publisher.image_background
        )
      },
      descriptionRaw: result.description_raw
    )
  }
  
  static func mapDetailGameEntitiesToDomain(
    input gameEntities: [GameEntity]
  ) -> [DetailGameModel] {
    var arrayRes: [DetailGameModel] = [DetailGameModel]()
    
    for result in gameEntities{
      let temp =  DetailGameModel(
        id: Int(result.id),
        isFavorite: result.isFavorite,
        slug: result.slug,
        name: result.name,
        nameOriginal: result.name_original,
        description: result.desc,
        released: result.released,
        updated: result.updated,
        backgroundImage: result.background_image,
        backgroundImageAdditional: result.background_image_additional,
        website: result.website,
        rating: result.rating,
        added: result.added,
        playtime: result.playtime,
        achievementsCount: result.ratings_count,
        ratingsCount: result.reviews_count,
        suggestionsCount: result.suggestions_count,
        reviewsCount: result.achievements_count,
        parentPlatforms: result.parent_platforms.map { platform in
          return PlatformModel(
            id: platform.id,
            name: platform.name,
            slug: platform.slug
          )
        },
        platforms: result.platforms.map { data in
          return DetailPlatformModel(
            id: data.id,
            platform: PlatformDetailsModel(
              id: data.platform!.id,
              name: data.platform?.name,
              slug: data.platform?.slug,
              image: data.platform?.image,
              yearEnd: data.platform?.year_end,
              yearStart: data.platform?.year_start,
              gamesCount: data.platform?.games_count,
              imageBackground: data.platform?.image_background
            ),
            releasedAt: data.released_at,
            requirements: PlatformRequirementModel(
              id: data.requirements!.id,
              minimum: data.requirements?.minimum
            )
          )
        },
        stores: result.stores.map { store in
           return StoreDetailsModel(
            id: store.id,
            url: store.url,
            store: StoreModel(
              id: store.store!.id,
              name: store.store?.name,
              slug: store.store?.slug,
              gamesCount: store.store?.games_count,
              domain: store.store?.domain,
              imageBackground: store.store?.image_background
            )
           )
        },
        developers: result.developers.map { developer in
          return DeveloperInDetailGameModel(
            id: developer.id,
            name: developer.name,
            slug: developer.slug,
            gamesCount: developer.games_count,
            imageBackground: developer.image_background
          )
        },
        genres: result.genres.map { genre in
          return GenreInDetailsModel(
            id: genre.id,
            name: genre.name,
            slug: genre.slug,
            gamesCount: genre.games_count,
            imageBackground: genre.image_background
          )
        },
        tags: result.tags.map { tag in
          return TagModel(
            id: tag.id,
            name: tag.name,
            slug: tag.slug,
            gamesCount: tag.games_count,
            imageBackground: tag.image_background
          )
        },
        publishers: result.publishers.map { publisher in
          return PublisherModel(
            id: publisher.id,
            name: publisher.name,
            slug: publisher.slug,
            gamesCount: publisher.games_count,
            imageBackground: publisher.image_background
          )
        },
        descriptionRaw: result.description_raw
      )
      
      arrayRes.append(temp)
    }
    
    return arrayRes
  }
  
  static func mapDetailGameResponsesToDomains(
    input detailGameResponses: DetailGameResponse
  ) -> DetailGameModel {
    
    var listParentPlatform:[PlatformModel] = [PlatformModel]()
    if detailGameResponses.parent_platforms != nil {
      for parentPlatform in (detailGameResponses.parent_platforms)! {
        listParentPlatform.append(
          PlatformModel(
            id: UUID(),
            name: parentPlatform.platform.name,
            slug: parentPlatform.platform.slug
          )
        )
      }
    }
    
    var listPlatform: [DetailPlatformModel] = [DetailPlatformModel]()
    if detailGameResponses.platforms != nil {
      for platform in (detailGameResponses.platforms)! {
        let detail: PlatformDetailsModel = PlatformDetailsModel(
          id: UUID(),
          name: platform.platform?.name ?? "Unknown Name",
          slug: platform.platform?.slug ?? "Unknown Slug",
          image: platform.platform?.image ?? "",
          yearEnd: platform.platform?.year_end ?? 0,
          yearStart: platform.platform?.year_start ?? 0,
          gamesCount: platform.platform?.games_count ?? 0,
          imageBackground: platform.platform?.image_background ?? ""
        )
        
        let requirement = PlatformRequirementModel(
          id: UUID(),
          minimum: platform.requirements?.minimum ?? ""
        )
        
        listPlatform.append(
          DetailPlatformModel(
            id: UUID(),
            platform: detail,
            releasedAt: platform.released_at ?? "",
            requirements: requirement
          )
        )
      }
    }
    
    var listStore: [StoreDetailsModel] = [StoreDetailsModel]()
    if detailGameResponses.stores != nil{
      for store in (detailGameResponses.stores)! {
        listStore.append(
          StoreDetailsModel(
            id: UUID(),
            url: store.url,
            store: StoreModel(
              id: UUID(),
              name: store.store?.name,
              slug: store.store?.slug,
              gamesCount: store.store?.games_count,
              domain: store.store?.domain,
              imageBackground: store.store?.image_background
            )
          )
        )
      }
    }
    
    var listDeveloper: [DeveloperInDetailGameModel] = [DeveloperInDetailGameModel]()
    if detailGameResponses.developers != nil {
      for developer in (detailGameResponses.developers)! {
        listDeveloper.append(
          DeveloperInDetailGameModel(
            id: UUID(),
            name: developer.name,
            slug: developer.slug,
            gamesCount: developer.games_count,
            imageBackground: developer.image_background
          )
        )
      }
    }

    var listGenre: [GenreInDetailsModel] = [GenreInDetailsModel]()
    if detailGameResponses.genres != nil {
      for genre in (detailGameResponses.genres)! {
        listGenre.append(
          GenreInDetailsModel(
            id: UUID(),
            name: genre.name,
            slug: genre.slug,
            gamesCount: genre.games_count,
            imageBackground: genre.image_background
          )
        )
      }
    }

    var listTag: [TagModel] = [TagModel]()
    if detailGameResponses.tags != nil{
      for tag in (detailGameResponses.tags)! {
        listTag.append(
          TagModel(
            id: UUID(),
            name: tag.name,
            slug: tag.slug,
            gamesCount: tag.games_count,
            imageBackground: tag.image_background
          )
        )
      }
    }

    var listPublisher: [PublisherModel] = [PublisherModel]()
    if detailGameResponses.publishers != nil {
      for publisher in (detailGameResponses.publishers)! {
        listPublisher.append(
          PublisherModel(
            id: UUID(),
            name: publisher.name,
            slug: publisher.slug,
            gamesCount: publisher.games_count,
            imageBackground: publisher.image_background
          )
        )
      }
    }
    
    return DetailGameModel(
      id: detailGameResponses.id,
      isFavorite: false, //default 
      slug: detailGameResponses.slug ?? "Unknown slug",
      name: detailGameResponses.name ?? "Unknown Name",
      nameOriginal: detailGameResponses.name_original ?? "Unknown Original Name",
      description: detailGameResponses.description ?? "No description",
      released: detailGameResponses.released ?? "Unknown released",
      updated: detailGameResponses.updated ?? "Unknown last updates",
      backgroundImage: detailGameResponses.background_image ?? "",
      backgroundImageAdditional: detailGameResponses.background_image_additional ?? "",
      website: detailGameResponses.website ?? "",
      rating: detailGameResponses.rating ?? 0.0,
      added: detailGameResponses.added ?? 0,
      playtime: detailGameResponses.playtime ?? 0,
      achievementsCount: detailGameResponses.achievements_count ?? 0,
      ratingsCount: detailGameResponses.ratings_count ?? 0,
      suggestionsCount: detailGameResponses.suggestions_count ?? 0,
      reviewsCount: detailGameResponses.reviews_count ?? 0,
      parentPlatforms: listParentPlatform,
      platforms: listPlatform ,
      stores: listStore,
      developers: listDeveloper,
      genres: listGenre,
      tags: listTag,
      publishers: listPublisher,
      descriptionRaw: detailGameResponses.description_raw ?? ""
    )
  }
}
