local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local home_dir = vim.env.HOME

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local bundles = {
    vim.fn.glob(
        home_dir
        .. "/java-debug/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.53.0.jar",
        1
    ),
}
vim.list_extend(
    bundles,
    vim.split(
        vim.fn.glob(
            home_dir .. "/java-test/vscode-java-test/server/org.eclipse.jdt.junit5.runtime_1.1.100.v20220907-0450.jar",
            1
        ),
        "\n"
    )
)
local workspace_dir = home_dir .. "/projects/java_projects/nvim/" .. project_name
local config = {
    capabilities = capabilities,
    cmd = {

        "/usr/lib/jvm/java-17-openjdk-amd64/bin/java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",

        "-jar",
        home_dir .. "/eclipse-jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",

        "-configuration",
        home_dir .. "/eclipse-jdtls/config_linux",

        "-data",
        workspace_dir,
    },

    root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew" }),

    settings = {
        java = {},
    },

    init_options = {
        bundles = bundles,
    },
}
require("jdtls").start_or_attach(config)
