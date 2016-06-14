import Foundation

public class NSDecimalNumberTransform: TransformType {
    public typealias Object = NSDecimalNumber
    public typealias JSON = String

    public init() {}

    public func transformFromJSON(_ value: AnyObject?) -> NSDecimalNumber? {
        if let string = value as? String {
            return NSDecimalNumber(string: string)
        }
        if let double = value as? Double {
            return NSDecimalNumber(value: double)
        }
        return nil
    }

    public func transformToJSON(_ value: NSDecimalNumber?) -> String? {
        guard let value = value else { return nil }
        return value.description
    }
}
