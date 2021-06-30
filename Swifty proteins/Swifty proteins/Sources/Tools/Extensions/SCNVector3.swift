import Foundation
import SceneKit

public extension SCNVector3
{
	/**
	* Negates the vector described by SCNVector3 and returns
	* the result as a new SCNVector3.
	*/
	func negate() -> SCNVector3 {
		return self * -1
	}

	/**
	* Negates the vector described by SCNVector3
	*/
	mutating func negated() -> SCNVector3 {
		self = negate()
		return self
	}

	/**
	* Returns the length (magnitude) of the vector described by the SCNVector3
	*/
	func length() -> Float {
		return sqrtf(x*x + y*y + z*z)
	}

	/**
	* Normalizes the vector described by the SCNVector3 to length 1.0 and returns
	* the result as a new SCNVector3.
	*/
	func normalized() -> SCNVector3 {
		return self / length()
	}

	/**
	* Normalizes the vector described by the SCNVector3 to length 1.0.
	*/
	mutating func normalize() -> SCNVector3 {
		self = normalized()
		return self
	}

	/**
	* Calculates the distance between two SCNVector3. Pythagoras!
	*/
	func distance(vector: SCNVector3) -> Float {
		return (self - vector).length()
	}

	/**
	* Calculates the dot product between two SCNVector3.
	*/
	func dot(vector: SCNVector3) -> Float {
		return x * vector.x + y * vector.y + z * vector.z
	}

	/**
	* Calculates the cross product between two SCNVector3.
	*/
	func cross(vector: SCNVector3) -> SCNVector3 {
		return SCNVector3Make(y * vector.z - z * vector.y, z * vector.x - x * vector.z, x * vector.y - y * vector.x)
	}
}

/**
* Adds two SCNVector3 vectors and returns the result as a new SCNVector3.
*/
public func + (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
	return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
}

/**
* Increments a SCNVector3 with the value of another.
*/
public func += ( left: inout SCNVector3, right: SCNVector3) {
	left = left + right
}

/**
* Subtracts two SCNVector3 vectors and returns the result as a new SCNVector3.
*/
public func - (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
	return SCNVector3Make(left.x - right.x, left.y - right.y, left.z - right.z)
}

/**
* Decrements a SCNVector3 with the value of another.
*/
public func -= ( left: inout SCNVector3, right: SCNVector3) {
	left = left - right
}

/**
* Multiplies two SCNVector3 vectors and returns the result as a new SCNVector3.
*/
public func * (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
	return SCNVector3Make(left.x * right.x, left.y * right.y, left.z * right.z)
}

/**
* Multiplies a SCNVector3 with another.
*/
public func *= ( left: inout SCNVector3, right: SCNVector3) {
	left = left * right
}

/**
* Multiplies the x, y and z fields of a SCNVector3 with the same scalar value and
* returns the result as a new SCNVector3.
*/
public func * (vector: SCNVector3, scalar: Float) -> SCNVector3 {
	return SCNVector3Make(vector.x * scalar, vector.y * scalar, vector.z * scalar)
}

/**
* Multiplies the x and y fields of a SCNVector3 with the same scalar value.
*/
public func *= ( vector: inout SCNVector3, scalar: Float) {
	vector = vector * scalar
}

/**
* Divides two SCNVector3 vectors abd returns the result as a new SCNVector3
*/
public func / (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
	return SCNVector3Make(left.x / right.x, left.y / right.y, left.z / right.z)
}

/**
* Divides a SCNVector3 by another.
*/
public func /= ( left: inout SCNVector3, right: SCNVector3) {
	left = left / right
}

/**
* Divides the x, y and z fields of a SCNVector3 by the same scalar value and
* returns the result as a new SCNVector3.
*/
public func / (vector: SCNVector3, scalar: Float) -> SCNVector3 {
	return SCNVector3Make(vector.x / scalar, vector.y / scalar, vector.z / scalar)
}

/**
* Divides the x, y and z of a SCNVector3 by the same scalar value.
*/
public func /= ( vector: inout SCNVector3, scalar: Float) {
	vector = vector / scalar
}

/**
* Negate a vector
*/
public func negate(vector: SCNVector3) -> SCNVector3 {
	return vector * -1
}

/**
* Returns the length (magnitude) of the vector described by the SCNVector3
*/
public func length(_ vector: SCNVector3) -> Float
{
	return sqrtf(vector.x*vector.x + vector.y*vector.y + vector.z*vector.z)
}

/**
* Returns the distance between two SCNVector3 vectors
*/
public func distance(_ vectorStart: SCNVector3, _ vectorEnd: SCNVector3) -> Float {
	return length(vectorEnd - vectorStart)
}

/**
* Returns the distance between two SCNVector3 vectors
*/
public func normalize(_ vector: SCNVector3) -> SCNVector3 {
	return vector / length(vector)
}

/**
* Calculates the dot product between two SCNVector3 vectors
*/
public func dotProduct(_ left: SCNVector3, _ right: SCNVector3) -> Float {
	return left.x * right.x + left.y * right.y + left.z * right.z
}

/**
* Calculates the cross product between two SCNVector3 vectors
*/
public func crossProduct(_ left: SCNVector3, _ right: SCNVector3) -> SCNVector3 {
	return SCNVector3Make(left.y * right.z - left.z * right.y, left.z * right.x - left.x * right.z, left.x * right.y - left.y * right.x)
}

/**
* Calculates the SCNVector from lerping between two SCNVector3 vectors
*/
public func lerp(_ vectorStart: SCNVector3, _ vectorEnd: SCNVector3, _ t: Float) -> SCNVector3 {
	return SCNVector3Make(vectorStart.x + ((vectorEnd.x - vectorStart.x) * t), vectorStart.y + ((vectorEnd.y - vectorStart.y) * t), vectorStart.z + ((vectorEnd.z - vectorStart.z) * t))
}

/**
* Project the vector, vectorToProject, onto the vector, projectionVector.
*/
public func project(_ vectorToProject: SCNVector3, _ projectionVector: SCNVector3) -> SCNVector3 {
	let scale: Float = dotProduct(projectionVector, vectorToProject) / dotProduct(projectionVector, projectionVector)
	let v: SCNVector3 = projectionVector * scale
	return v
}
