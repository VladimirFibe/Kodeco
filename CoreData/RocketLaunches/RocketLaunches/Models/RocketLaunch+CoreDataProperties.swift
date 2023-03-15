import CoreData
import SwiftUI
extension RocketLaunch {
    @NSManaged public var name: String
    @NSManaged public var isViewed: Bool
    @NSManaged public var launchDate: Date?
    @NSManaged public var launchpad: String?
    @NSManaged public var notes: String?
    @NSManaged public var list: RocketLaunchList
    @NSManaged var tags: Set<RocketLaunchTag>?
    
    static func basicFetchRequest() -> FetchRequest<RocketLaunch> {
        FetchRequest(entity: RocketLaunch.entity(), sortDescriptors: [])
    }
    
    static func sortedFetchRequest() -> FetchRequest<RocketLaunch> {
        let launchDateSortDescriptor = NSSortDescriptor(key: "launchDate", ascending: true)
        return FetchRequest(entity: RocketLaunch.entity(), sortDescriptors: [launchDateSortDescriptor])
    }
    
    static func fetchRequestSortedByNameAndLaunchDate() -> FetchRequest<RocketLaunch> {
        let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let launchDateSortDescriptor = NSSortDescriptor(key: "launchDate", ascending: true)
        return FetchRequest(entity: RocketLaunch.entity(), sortDescriptors: [nameSortDescriptor, launchDateSortDescriptor])
    }
    
    static func unViewedLaunchesFetchRequest() -> FetchRequest<RocketLaunch> {
        let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let launchDateSortDescriptor = NSSortDescriptor(key: "launchDate", ascending: true)
        let isViewedPredicate = NSPredicate(format: "%K == %@", "isViewed", NSNumber(value: false))
        return FetchRequest<RocketLaunch>(entity: RocketLaunch.entity(),
                            sortDescriptors: [nameSortDescriptor, launchDateSortDescriptor],
                            predicate: isViewedPredicate)
    }
    
    static func launches(in list: RocketLaunchList) -> FetchRequest<RocketLaunch> {
        let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let launchDateSortDescriptor = NSSortDescriptor(key: "launchDate", ascending: true)
        let listPredicate = NSPredicate(format: "%K == %@", "list.name", list.name!)
        let isViewedPredicate = NSPredicate(format: "%K == %@", "isViewed", NSNumber(value: false))
        let combinedPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [listPredicate, isViewedPredicate])
        return FetchRequest<RocketLaunch>(entity: RocketLaunch.entity(),
                            sortDescriptors: [nameSortDescriptor, launchDateSortDescriptor],
                            predicate: combinedPredicate)
    }
    
    static func createWith(name: String,
                           notes: String,
                           launchDate: Date,
                           isViewed: Bool,
                           launchpad: String,
                           in list: RocketLaunchList,
                           with tags: Set<RocketLaunchTag> = [],
                           using managedObjectContext: NSManagedObjectContext) {
        let launch = RocketLaunch(context: managedObjectContext)
        launch.name = name
        launch.notes = notes
        launch.launchpad = launchpad
        launch.isViewed = isViewed
        launch.launchDate = launchDate
        launch.list = list
        launch.tags = tags
        do {
            try managedObjectContext.save()
            
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")

        }
    }
}
 
