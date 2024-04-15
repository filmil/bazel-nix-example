load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "io_tweag_rules_nixpkgs",
    strip_prefix = "rules_nixpkgs-b6cf1734d4c52dba33f942d6b5cd5538dfa6e0b6",
    urls = ["https://github.com/tweag/rules_nixpkgs/archive/b6cf1734d4c52dba33f942d6b5cd5538dfa6e0b6.tar.gz"],
)

load("@io_tweag_rules_nixpkgs//nixpkgs:repositories.bzl", "rules_nixpkgs_dependencies")

rules_nixpkgs_dependencies()

load("@io_tweag_rules_nixpkgs//nixpkgs:nixpkgs.bzl", "nixpkgs_local_repository", "nixpkgs_package")

# It is recommended to keep nixpkgs of nix-shell (which provide Bazel),
# and nixpkgs of Bazel Workspace in sync - otherwise one may
# got hit with nasty glibc mismatch errors.
nixpkgs_local_repository(
    name = "nixpkgs",
    nix_file = "//:nixpkgs.nix",
    nix_file_deps = [
        "//:nixpkgs.json"
    ],
)

# Import GNU Hello binary into the build as an external repository.
nixpkgs_package(
    name = "hello",
    repository = "@nixpkgs",
    nix_file_deps = [
        "//:nixpkgs.json"
    ],
    # Indentation must be exactly like this.
    build_file_content = """
filegroup(
    name = "hello_bin",
    srcs = [ "bin/hello" ],
    visibility = [ "//visibility:public" ],
)
    """,
)

