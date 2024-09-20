import XCTest

@testable import Recipes

class BookmarkRepositoryTests: XCTestCase {
    
    private var repository: BookmarkRepository!
    private var userDefaults: UserDefaults!
    private var key = "Bookmarks"
    
    override func setUp() async throws {
        try await super.setUp()
        
        userDefaults = UserDefaults(suiteName: #file)
        repository = BookmarkRepository(userDefaults: userDefaults)
    }
    
    override func tearDown() async throws {
        try await super.tearDown()

        userDefaults.removePersistentDomain(forName: #file)
    }
    
    func test_whenBookmarkRecipeId_thenRecipeIsSaved() {
        // given
        let id = "1"
        
        // when
        repository.bookmarkRecipe(id: id)
        
        // then
        XCTAssertEqual(userDefaults.array(forKey: key) as? [String], [id])
    }
    
    func test_whenTwoRecipeIdsBookmarked_thenRecipesAreSaved() {
        // given
        let ids = ["3", "4" ]
        
        // when
        for id in ids {
            repository.bookmarkRecipe(id: id)
        }
        
        // then
        XCTAssertEqual(userDefaults.array(forKey: key) as? [String], ids)
    }
    
    func test_whenRecipeIsUnbookmarked_thenRecipeIsRemoved() {
        // given
        let id = "1"
        let id2 = "2"

        // when
        repository.bookmarkRecipe(id: id)
        repository.bookmarkRecipe(id: id2)
        repository.unbookmarkRecipe(id: id)

        // then
        XCTAssertEqual(userDefaults.array(forKey: key) as? [String], [id2])
    }
    
    func test_whenRecipeIsBookmarked_thenIsRecipeIsBookmarkedReturnsTrue() {
        // given
        let id = "1"

        // when
        repository.bookmarkRecipe(id: id)

        // then
        XCTAssertTrue(repository.isRecipeBookmarked(id: id))
    }
}

