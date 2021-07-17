import Foundation

class OptionalWrap<T> {
	public var value: T? = nil

	public var hasValue: Bool {
		value != nil
	}
}
