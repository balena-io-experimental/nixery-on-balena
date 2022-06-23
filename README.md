# nixery-on-balena

Run an instance of [nixery](https://nixery.dev/) on balena!

## Getting Started

You can one-click-deploy this project to balena using the button below:

[![deploy-with-balena](https://balena.io/deploy.svg)](https://dashboard.balena-cloud.com/deploy?repoUrl=https://github.com/balena-io-playground/nixery-on-balena)

## Manual Deployment

Alternatively, deployment can be carried out by manually creating a [balenaCloud account](https://dashboard.balena-cloud.com) and application, flashing a device, downloading the project and pushing it via the [balena CLI](https://github.com/balena-io/balena-cli).

## Usage

Enable the Public device URL or just point to `nixery.local` to see the default nixery site:

```bash
browse http://nixery.local
```

Pull nixery composed images but instead of `nixery.dev` use `nixery.local` or the Public device URL.

```bash
docker run --rm -it nixery.local/shell/git/htop bash
```

## Customization

### Environment Variables

Supported environment variables are outlined in the [nixery documentation](https://nixery.dev/run-your-own.html#3-prepare-configuration)

## Contributing

Please open an issue or submit a pull request with any features, fixes, or changes.
