Commands = {
    name = nil,
    execute = nil
}
Commands.__index = Commands

function Commands:create(name, execute)
    local this = {
        name = name,
        execute = execute
    }

    setmetatable(this, Commands)
    return this
end
