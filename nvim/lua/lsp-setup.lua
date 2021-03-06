-- Setup nvim-cmp.
local lspkind = require('lspkind')
local luasnip = require('luasnip')
local cmp = require('cmp')

cmp.setup({
  snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
      presets = 'codicons',
      maxwidth = 50,
      --[[
      symbol_map = {
        Text = "",
        Method = "",
        Function = "",
        Constructor = "",
        Field = "ﰠ",
        Variable = "",
        Class = "ﴯ",
        Interface = "",
        Module = "",
        Property = "ﰠ",
        Unit = "塞",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "פּ",
        Event = "",
        Operator = "",
        TypeParameter = ""
      },
      ]]--
      before = function (entry, vim_item)
        return vim_item
      end
    })
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For luasnip users.
  }, {
    { name = 'buffer' },
    { name = 'path' },
  })
})


-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})


-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})


-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- LUA LSP see official installation guide for sumneko_lua
require'lspconfig'.sumneko_lua.setup {
  cmd = { os.getenv('HOME') .. '/prog/language_server/lua-language-server/bin/lua-language-server' },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ','),
      },
      diagnostics = {
        globals = {'vim', 'use'}
      },
      telemetry = {
        enable = false,
      },
    },
  },
  capabilities = capabilities,
}

-- install typescript LSP (tsserver) npm install -g typescript-language-server
require'lspconfig'.tsserver.setup {
  capabilities = capabilities
}

-- install c/c++ LSP (ccls) apt install ccls
require'lspconfig'.ccls.setup {
  single_file_support = true,
  root_dir = function ()
    return vim.loop.cwd()
  end,
  capabilities = capabilities
}

-- install json LSP npm install -g vscode-json-languageserver
require'lspconfig'.jsonls.setup {
  cmd = { "vscode-json-languageserver", "--stdio" },
  capabilities = capabilities
}

require'lspconfig'.cssls.setup {
  capabilities = capabilities,
}

-- seems not to be useful
require'lspconfig'.html.setup {
  capabilities = capabilities,
}

-- install python lsp: python3 -m pip install --user 'python-language-server[all]'
require'lspconfig'.pylsp.setup{
  cmd = { "pyls" },
  capabilities = capabilities
}

require'lspconfig'.bashls.setup{
  capabilities = capabilities
}

require'lspconfig'.volar.setup{
  capabilities = capabilities,
  init_options = {
    typescript = {
      serverPath = '/usr/local/lib/node_modules/typescript/lib/tsserverlibrary.js'
    }
  }
}

--install jdtls LSP server
-- clone repository git clone https://github.com/eclipse/eclipse.jdt.ls.git
-- mvn clean verify -DskipTests=true
-- set JDTLS_HOME to .../eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository
require'lspconfig'.jdtls.setup{
  capabilities = capabilities
}

-- load snippets
require('luasnip/loaders/from_vscode').load()
require('luasnip/loaders/from_vscode').load({
  paths = '~/.config/nvim/my-snippets'
})

