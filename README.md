# Minimal bazel + nix example [![Test status](https://github.com/filmil/bazel-nix-example/workflows/Test/badge.svg)](https://github.com/filmil/bazel-nix-example/workflows/Test/badge.svg)

This is a minimal example that shows you how to pull in a hermetic instance of
a binary from a local [nix][nix] repository installation and use it in your bazel
build.

It builds on top of https://github.com/filmil/bazel_local_nix, which is a set of
rules that sets up a local hermetic nix repository.

Now, that one in turn builds on top of https://github.com/tweag/rules_nixpkgs.
However, *that* repository does not give simple examples. It gives complex
examples that set up hermetic toolchains and such. But there isn't really a
very basic example that shows how you would just take one simple binary from a
nix repository and use it in your build.

This repo fixes that issue.

## How to use

Clone the repository. Install `bazel`. Then do the following:

```
bazel build //:hello
```

This will produce a file `bazel-bin/hello.txt`, which contains some text
produced by running a hermetic instance of [GNU Hello][gnuh].  You can take
a look at [BUILD.bazel](BUILD.bazel) to see how this is achieved.

[nix]: https://nixos.org
[gnuh]: https://www.gnu.org/software/hello

