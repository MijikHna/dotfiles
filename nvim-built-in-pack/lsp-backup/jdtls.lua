--[[  Java LSP:
    1: clone repository git clone https://github.com/eclipse/eclipse.jdt.ls.git,
    2: mvn clean verify -DskipTests=true
    3: set JDTLS_HOME to .../eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository
  ]] --
-- lspconfig.jdtls.setup({ capabilities = capabilities })
