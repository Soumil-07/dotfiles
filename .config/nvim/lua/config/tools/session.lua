-- This is needed because trees cannot be restored
require('auto-session').setup {
    pre_save_cmds = {"NvimTreeClose"},
}
