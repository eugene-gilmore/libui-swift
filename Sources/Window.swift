import clibui

public class Window: Control {
	let op:OpaquePointer;
	private var onCloseHandler: () -> Int
	private var onContentsSizeChangedHandler: () -> Void
	private var onPositionChangedHandler: () -> Void

	public init(title:String, width:Int32, height:Int32, withMenu:Bool = false) {
		self.op = clibui.uiNewWindow(title, width, height, withMenu ? 1 : 0);
		self.onCloseHandler = { return 0 }
		self.onContentsSizeChangedHandler = {}
		self.onPositionChangedHandler = {}

		super.init(c: UnsafeMutablePointer(self.op))
	}

	public func on(contentSizeChanged: () -> Void) -> Void {
		onContentsSizeChangedHandler = contentSizeChanged
		clibui.uiWindowOnContentSizeChanged(self.op, { (w, d) -> Void in
			if let windowPointer = d {
				let window = Unmanaged<Window>.fromOpaque(windowPointer).takeUnretainedValue()

				window.onContentsSizeChangedHandler()
			}
		}, UnsafeMutablePointer<Void>(Unmanaged.passUnretained(self).toOpaque()))		
	}

	public func on(positionChanged: () -> Void) -> Void {
		onPositionChangedHandler = positionChanged
		clibui.uiWindowOnPositionChanged(self.op, { (w, d) -> Void in
			if let windowPointer = d {
				let window = Unmanaged<Window>.fromOpaque(windowPointer).takeUnretainedValue()

				window.onPositionChangedHandler()
			}
		}, UnsafeMutablePointer<Void>(Unmanaged.passUnretained(self).toOpaque()))		
	}

	public func on(closing: () -> Int) {
		onCloseHandler = closing
		clibui.uiWindowOnClosing(self.op, { (w, d) -> Int32 in
			if let windowPointer = d {
				let window = Unmanaged<Window>.fromOpaque(windowPointer).takeUnretainedValue()

				return Int32(window.onCloseHandler())
			}

			return -1
		}, UnsafeMutablePointer<Void>(Unmanaged.passUnretained(self).toOpaque()))
	}

	public var title:String {
		set {
			clibui.uiWindowSetTitle(self.op, newValue)
		}
		get {
			return String(cString: clibui.uiWindowTitle(self.op))
		}
	}

	public var borderless:Bool {
		set {
			clibui.uiWindowSetBorderless(self.op, newValue ? 1 : 0)
		}
		get {
			return clibui.uiWindowBorderless(self.op) == 1
		}
	}

	public var fullscreen:Bool {
		set {
			clibui.uiWindowSetFullscreen(self.op, newValue ? 1 : 0)
		}
		get {
			return clibui.uiWindowFullscreen(self.op) == 1
		}
	}

	public var margined:Bool {
		set {
			clibui.uiWindowSetMargined(self.op, newValue ? 1 : 0)
		}
		get {
			return clibui.uiWindowMargined(self.op) == 1
		}
	}

	public func center() -> Void {
		clibui.uiWindowCenter(self.op)
	}

	public var position: (Int, Int) {
		set {
			let (x, y) = newValue
			clibui.uiWindowSetPosition(self.op, Int32(x), Int32(y))
		}
		get {
			var x:Int32 = -1
			var y:Int32 = -1
			clibui.uiWindowPosition(self.op, &x, &y)
			return (Int(x), Int(y))
		}
	}

	public var contentSize: (Int, Int) {
		set {
			let (width, height) = newValue
			clibui.uiWindowSetContentSize(self.op, Int32(width), Int32(height))
		}
		get {
			var width:Int32 = -1
			var height:Int32 = -1
			clibui.uiWindowContentSize(self.op, &width, &height)
			return (Int(width), Int(height))
		}
	}

	public func set(child:Control) -> Void {
		uiWindowSetChild(self.op, child.control)
	}
}