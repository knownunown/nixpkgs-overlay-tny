{ sops-install-secrets, lib }:
sops-install-secrets.overrideModAttrs(_: {
    postBuild = builtins.trace _.postBuild "";
})
