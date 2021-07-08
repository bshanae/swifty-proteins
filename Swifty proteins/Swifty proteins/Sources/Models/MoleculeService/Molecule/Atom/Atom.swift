import SceneKit

struct Atom {
	public let id: Int
	public let position: SCNVector3
	public let kind: Kind

	public static func parse(id:Int, stringKind:String, x: Double, y: Double, z: Double) -> Atom {
		Atom(
			id: id,
			kind: Kind.init(rawValue: stringKind) ?? Kind.other,
			position: SCNVector3.init(x, y, z)
		)
	}

	private init(id:Int, kind:Kind, position: SCNVector3) {
        self.id = id
		self.kind = kind
		self.position = position
    }
}
