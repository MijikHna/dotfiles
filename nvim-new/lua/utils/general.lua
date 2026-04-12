local General = {}

function General.format_on_save()
  vim.lsp.buf.format({
    filter = function(client)
      if client.name == 'docker_compose_language_service' then
        return false
      end

      return true
    end,
    async = false
  })
end

return General
