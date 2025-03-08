require("config.autocmds")
require("config.builtins")
require("config.keymaps")
require("config.options")

-- must require everything else before config lazy
require("config.lazy")
