local home = os.getenv("HOME")

local _M = {}

function _M.get()
    -- monta a tabela de configurações quando chamada
    local vars = {
        terminal   = "kitty",
        editor     = os.getenv("EDITOR") or "nano",
        modkey     = "Mod4",
        home       = home,         -- opcional, se quiser expor o HOME
    }

    -- comando completo para abrir o editor
    vars.editor_cmd = vars.terminal .. " -e " .. vars.editor

    return vars
end

-- torna o módulo chamável: module() → _M.get()
return setmetatable({},
    { __call = function(_, ...) return _M.get(...) end }
)