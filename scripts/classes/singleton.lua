function Singleton(super)
    local obj = {}
    obj.__index = obj
    setmetatable(obj, super)

    function obj.new(...)
        if obj._instance then
            return obj._instance
        end

        local instance = setmetatable({}, obj)
        if instance.ctor then
            instance:ctor(...)
        end

        obj._instance = instance
        return obj._instance
    end

    return obj
end

-- local class = Singleton()
-- local a = class.new()
-- local b = class.new()
-- a.name = "Singleton Pattern"

-- print(a.name)
-- print(b.name)

---------------------------------------------------------------------------
-- OUTPUT
---------------------------------------------------------------------------
-- Singleton Pattern
-- Singleton Pattern