GROUP_DEPTH ?= 1
NVIM_EXEC ?= nvim

all: test documentation

# Use sequential tests to save execution resources due to presence of timing tests
test:
	$(NVIM_EXEC) --version | head -n 1 && echo ''
	$(NVIM_EXEC) --headless --noplugin -u ./scripts/minimal_init.lua \
		-c "lua require('mini.test').setup()" \
		-c "lua MiniTest.run({ execute = { reporter = MiniTest.gen_reporter.stdout({ group_depth = $(GROUP_DEPTH) }) } })"

test_file:
	$(NVIM_EXEC) --version | head -n 1 && echo ''
	$(NVIM_EXEC) --headless --noplugin -u ./scripts/minimal_init.lua \
		-c "lua require('mini.test').setup()" \
		-c "lua MiniTest.run_file('$(FILE)', { execute = { reporter = MiniTest.gen_reporter.stdout({ group_depth = $(GROUP_DEPTH) }) } })"

documentation:
	$(NVIM_EXEC) --headless --noplugin -u ./scripts/minimal_init.vim -c "lua require('mini.doc').generate()" -c "qa!"
