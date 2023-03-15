import Foundation
import CoreData


extension RocketLaunchTag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RocketLaunchTag> {
        return NSFetchRequest<RocketLaunchTag>(entityName: "RocketLaunchTag")
    }

    @NSManaged public var name: String?
    @NSManaged public var launches: NSOrderedSet?

}

// MARK: Generated accessors for launches
extension RocketLaunchTag {

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

extension RocketLaunchTag : Identifiable {

}
