import Foundation

enum LocalRecipeDataSourceError: Error {
    case fileNotFound(String)
}

extension LocalRecipeDataSourceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case.fileNotFound(let fileName):
            return "\(fileName) \("error.file-not-found".localized)"
        }
    }
}
