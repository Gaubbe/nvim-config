local M = {}

--- All the crate types in cargo
--- @alias CargoCrateType
--- | 'bin' # A binary target
--- | 'lib' # A Rust library target
--- | 'dylib' # A Rust dynamic library target
--- | 'staticlib' # A native static library target
--- | 'cdylib' # A native dynamic library target
--- | 'rlib' # A different Rust library target
--- | 'proc-macro' # A procedural macro target

--- All the target kinds recognized by cargo
--- @alias CargoTargetKind
--- | 'bin' # A binary target
--- | 'lib' # A Rust library target
--- | 'dylib' # A Rust dynamic library target
--- | 'staticlib' # A native static library target
--- | 'cdylib' # A native dynamic library target
--- | 'rlib' # A different Rust library target
--- | 'proc-macro' # A procedural macro target
--- | 'example' # An example target
--- | 'test' # An integration test target
--- | 'bench' # A benchmark target
--- | 'custom-build' # A build script target

--- A representation of a package target given by the cargo metadata command
--- https://doc.rust-lang.org/cargo/commands/cargo-metadata.html
--- @class CargoTarget
--- @field kind CargoTargetKind[] The kinds of the target
--- @field crate_types CargoCrateType[] The crate types of the target
--- @field name string The name of the target
--- @field src_path string The absolute file path to the root source file
--- @field edition string The Rust edition of the target
--- @field required_features string[] The required features of this target
--- @field doc boolean Whether the target should be documented
--- @field doctest boolean Whether the target has doc tests enabled
--- @field test boolean Whether the target should be built with --test

--- A representation of a package dependency given by the cargo metadata
--- command
--- https://doc.rust-lang.org/cargo/commands/cargo-metadata.html
--- @class CargoDependency
--- @field name string The name of the dependency
--- @field source string? The source ID of the dependency
--- @field req string The version requirement of the dependency
--- @field kind 'dev'|'build'|nil The kind of dependency
--- @field rename string? The renamed dependency, if applicable
--- @field optional boolean Whether the dependency is optional
--- @field uses_default_features boolean Whether the dependency uses its default features
--- @field features string[] List of enabled features
--- @field target string? The target platform of the dependency
--- @field path string? If this is a path dependency, the path to it
--- @field registry string? The URL of the registry this dependency is from
--- @field public public boolean Whether the dependency is public

--- A representation of a package as given by the cargo metadata command
--- https://doc.rust-lang.org/cargo/commands/cargo-metadata.html
--- @class CargoPackage
--- @field name string The name of the package
--- @field version string The version of the package
--- @field id string ID of the package. Useful for other cargo commands
--- @field license string? Type of license, if there is one
--- @field license_file string? File path to the license, if there is one
--- @field description string? Description of the package
--- @field source string? Source ID of the package
--- @field dependencies CargoDependency[] The dependencies of the package
--- @field targets CargoTarget[] The targets of the package
--- @field features table<string, string[]> The features of the target
--- @field manifest_path string File path to the manifest file
--- @field metadata any Metadata about the package
--- @field publish string[] List of registries the package may be published to
--- @field authors string[] List of authors of the package
--- @field categories string[] List of categories the package is assigned to
--- @field default_run string? Default binary picked by cargo run
--- @field rust_version string Rust version that the package uses
--- @field keywords string[] Keywords used for indexing the package
--- @field readme string? File path to the readme file
--- @field repository string? Repository of the package
--- @field homepage string? Homepage of the package
--- @field documentation string? Documentation for the package
--- @field edition string Edition of Rust for the package
--- @field links string? Native library link for the package

--- A representation of the metadata that cargo metadata returns
--- https://doc.rust-lang.org/cargo/commands/cargo-metadata.html
--- @class CargoMetadata
--- @field packages CargoPackage[] List of packages included in the workspace
--- @field workspace_members string[] List of all the workspace members
--- @field resolve any Graph of the dependencies
--- @field target_directory string The target directory
--- @field version 1 The version of the metadata command output
--- @field workspace_root string The root directory of the workspace
--- @field metadata any The metadata of the workspace

--- Obtains the metadata of the current workspace
--- @param client vim.lsp.Client The LSP client to use for the root directory
--- @return CargoMetadata # The metadata
M.get_metadata = function (client)
	--- @type CargoMetadata
	local metadata

	local obj = vim.system({
		'cargo',
		'metadata',
		'--no-deps',
		'--format-version',
		'1',
	},{
		cwd = client.root_dir,
	}):wait()

	if obj.stdout ~= nil then
		metadata = vim.json.decode(obj.stdout)
	end

	return metadata
end

--- Creates the cargo related user commands
--- @param client vim.lsp.Client
--- @param bufnr integer
M.create_cargo_user_commands = function (client, bufnr)
	vim.api.nvim_buf_create_user_command(bufnr, 'CargoRootDir', function ()
		vim.print(vim.inspect(client.root_dir))
	end, {})
	vim.api.nvim_buf_create_user_command(bufnr, 'CargoMetadata', function ()
		vim.print(vim.inspect(M.get_metadata(client)))
	end, {})
end

return M
