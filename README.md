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

### Prerequisites 

At the moment the only supported platform is `x86_64` under `Linux`.

#### Install `bazel`

I prefer downloading a [bazelisk][bzl] binary, and setting it somewhere in your
`$PATH` under the name `bazel`.

[bzl]: https://github.com/bazelbuild/bazelisk

#### Clone the repository.

```
git clone https://github.com/filmil/bazel-nix-example --recurse-submodules
```

Sorry about the "submodules" bit. This was the only way I could take in
the required `//tools` scripts.

### Build

```
bazel build //:hello
```

The first run will take its sweet time to install a local copy of `nix` into your
bazel cache.  Subsequent runs will take significantly less time.

### Results

This will produce a file `bazel-bin/hello.txt`, which contains some text
produced by running a hermetic instance of [GNU Hello][gnuh].  You can take
a look at [BUILD.bazel](BUILD.bazel) to see how this is achieved.

[nix]: https://nixos.org
[gnuh]: https://www.gnu.org/software/hello

## Why this matters

If you consider using `bazel` as your build system of choice, I hope at least part 
of your decision is based on bazel's ability to create hermetic builds.

Unfortunately, build hermeticity is not automatic. You have to make it happen.

Usually, this means you must bazelize every dependency your project has. With
many deps, this becomes a big additional task for the project maintainer. You
need to find a way to build your dependency hermetically, and expose it to
`bazel` so that it can be used in the build.

`nix` makes this step trivial, but it is invasive by default because it
requires installing into a path `/nix` which a regular user usually does
not have access to.

The approach I give here instead installs the nix repository into the
bazel cache dir, which allows `bazel` to set up the repo as part of
the project's build process.

The nixpkgs rules then allow us to make that installation available
to the bazel build comparatively easily. The nix hermeticity rules
allow us to guarantee the hermeticity of the resulting build.

In turn, this means the combination given here offers you an easy way
to bazelize every dependency, using the fact that nix already does
a lot of that legwork, and that nixpkgs rules are available to glue
the two systems together.



