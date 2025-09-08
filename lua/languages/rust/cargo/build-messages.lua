--- @meta CargoBuildMessages

--- @class CompilerMessage
--- @field reason "compiler-message"
--- @field package_id string
--- @field manifest_path string
--- @field target CargoTarget
--- @field message any

--- @class CompilerProfile
--- @field opt_level string
--- @field debuginfo integer
--- @field debug_assertions boolean
--- @field overflow_checks boolean
--- @field test boolean

--- @class ArtifactMessage
--- @field reason "compiler-artifact"
--- @field package_id string
--- @field manifest_path string
--- @field target CargoTarget
--- @field profile CompilerProfile
--- @field features string[]
--- @field filenames string[]
--- @field executable string?
--- @field fresh boolean

--- @class BuildScriptOutputMessage
--- @field reason "build-script-executed"
--- @field package_id string
--- @field linked_libs string[]
--- @field linked_paths string[]
--- @field cfgs string[]
--- @field env ([string, string])[]
--- @field out_dif string

--- @class BuildFinishedMessage
--- @field reason "build-finished"
--- @field success boolean

--- @alias CargoBuildMessage
--- | CompilerMessage
--- | ArtifactMessage
--- | BuildScriptOutputMessage
--- | BuildFinishedMessage
