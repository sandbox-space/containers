# Shared PHP container configuration (`_common`)

**This shared configuration is only used for PHP versions up to and including 8.4.**

The `_common` directory holds configuration (php.ini, php-fpm, conf.d, profile.d,
bin scripts, entrypoint) shared across the older PHP major versions (7.2 – 8.4).
The Dockerfiles of those versions copy the configuration from `_common` because
their build context is the parent `php/` directory (see `Makefile` → `docker build ... ../`).

## `_common` is not used from PHP 8.5 onwards

Starting with **PHP 8.5** the shared configuration was abandoned as unmaintainable.
Each major version from 8.5 up is configured **autonomously** — it keeps its own copy
of the entire configuration inside its own directory (e.g. `php/8.5/prod/...`,
`php/8.5/dev/...`) instead of pulling it from `_common`.

The build context stays the parent `php/` directory (`docker build ... ../`, and
`../../../` in the reusable CI workflow), so the only change versus the older versions
is *where the configuration lives* — the `COPY` paths point at the version's own
directory (`8.5/prod/...`) rather than at `_common/...`.

This lets every version be modified independently, without risking breakage of the others.

### Migrating a new major version (8.5 and up)

1. Copy the contents of `_common/{prod,dev}/fpm-alpine/` into `php/<version>/{prod,dev}/fpm-alpine/`.
2. In the Dockerfiles, change the `COPY` paths from `_common/...` to the version's own
   directory (`<version>/prod/...`, `<version>/dev/...`). The build context stays `../`.
3. Adjust the configuration further according to the specifics of that PHP version.
