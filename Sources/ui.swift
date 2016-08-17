import AppKit

import clibui

public struct InitOptions {
	var options:clibui.uiInitOptions

	public init() {
		options = clibui.uiInitOptions()
	}
}

public func initialize(options:inout InitOptions) -> String? {
	if let output = clibui.uiInit(&options.options) {
		return String(cString: output)
	}
	return nil
}

public func main() -> Void {
	clibui.uiMain()
}

public func quit() -> Void {
	clibui.uiQuit()
}

public func openFile(parent:Window) -> String? {
	if let cPath = clibui.uiOpenFile(parent.op) {
		return String(cString: cPath)
	}
	return nil
}

public func saveFile(parent:Window) -> String? {
	if let cPath = clibui.uiSaveFile(parent.op) {
		return String(cString: cPath)
	}
	return nil
}

public func messageBox(parent:Window, title:String, description:String) -> Void {
	clibui.uiMsgBox(parent.op, title, description)
}

public func messageBoxError(parent:Window, title:String, description:String) -> Void {
	clibui.uiMsgBoxError(parent.op, title, description)
}
