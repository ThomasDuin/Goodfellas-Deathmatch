local scripts = {}

function loadScript(name)
	scripts[name] = {}
	local buf = require("scripts/" .. name)
	if(buf == nil) then	
		scripts[name] = nil
		return false
	end
	scripts[name].script = buf
	print("Utilis: script loaded: " .. name)
	return true
end

function unloadScript(name)
	if(scripts[name].unload ~= nil) then
		scripts[name].unload()
	end
	scripts[name].script = nil
	package.loaded["scripts/" .. name] = nil
	print("Utilis: script unloaded: " .. name)
end

function isScriptLoaded(name)
	return (scripts[name] ~= nil)
end

function registerScriptUnload(scriptname, func)
	scripts[scriptname].unload = func
end