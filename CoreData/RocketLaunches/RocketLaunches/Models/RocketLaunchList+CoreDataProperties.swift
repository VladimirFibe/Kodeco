import Foundation
import CoreData


extension RocketLaunchList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RocketLaunchList> {
        return NSFetchRequest<RocketLaunchList>(entityName: "RocketLaunchList")
    }

    @NSManaged public var name: String?
    @NSManaged public var launches: [RocketLaunch]

    static func create(withName name: String, in managedObjectContext: NSManagedObjectContext) {
        let list = self.init(context: managedObjectContext)
        list.name = name
        do {
            try managedObjectContext.save()
            
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            
        }
    }
}

// MARK: Generated accessors for launches
extension RocketLaunchList {

    @objc(insertObject:inLaunchesAtIndex:)
    @NSManaged public func insertIntoLaunches(_ value: RocketLaunch, at idx: Int)

    @objc(removeObjectFromLaunchesAtIndex:)
    @NSManaged public func removeFromLaunches(at idx: Int)

    @objc(insertLaunches:atIndexes:)
    @NSManaged public func insertIntoLaunches(_ values: [RocketLaunch], at indexes: NSIndexSet)

    @objc(removeLaunchesAtIndexes:)
    @NSManaged public func removeFromLaunches(at indexes: NSIndexSet)

    @objc(replaceObjectInLaunchesAtIndex:withObject:)
    @NSManaged public func replaceLaunches(at idx: Int, with value: RocketLaunch)

    @objc(replaceLaunchesAtIndexes:withLaunches:)
    @NSManaged public func replaceLaunches(at indexes: NSIndexSet, with values: [RocketLaunch])

    @objc(addLaunchesObject:)
    @NSManaged public func addToLaunches(_ value: RocketLaunch)

    @objc(removeLaunchesObject:)
    @NSManaged public func removeFromLaunches(_ value: RocketLaunch)

    @objc(addLaunches:)
    @NSManaged public func addToLaunches(_ values: NSOrderedSet)

    @objc(removeLaunches:)
    @NSManaged public func removeFromLaunches(_ values: NSOrderedSet)

}

extension RocketLaunchList : Identifiable {

}
