import UIKit

extension FileManager {
    class LocalFileManager {
        static var shared = LocalFileManager()
        
        enum SearchPathDirectory {
            case documentDirectory, cachesDirectory, temporaryDirectory
        }
        
        // get directory
        func getDocumentsDirectory(_ searchPath: SearchPathDirectory) -> URL? {
            let paths = FileManager()
            
            switch searchPath {
            case .documentDirectory:
                return paths.urls(for: .documentDirectory, in: .userDomainMask).first
            case .cachesDirectory:
                return paths.urls(for: .cachesDirectory, in: .userDomainMask).first
            case .temporaryDirectory:
                paths.temporaryDirectory
                return nil
            }
        }
        
        // create file
        func createFile<T: Codable>(componentName: String, searchPath: SearchPathDirectory, content: T) {
            let url = getDocumentsDirectory(searchPath)?.appending(components: componentName)
            
            
        }
        
        // delete file
        
        // get file
        
        // create folder
        
        // delete folder
    }
}
