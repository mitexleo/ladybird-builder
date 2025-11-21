# Ladybird Builder GitHub Actions

This repository contains GitHub Actions workflows to automatically build and release Ladybird Browser for major Linux distributions.

## Overview

This is a **builder repository** that automatically:
- Clones the official Ladybird Browser source code from [LadybirdBrowser/ladybird](https://github.com/LadybirdBrowser/ladybird)
- Builds Ladybird Browser on Ubuntu and Fedora
- Tests with both GCC 14 and Clang 20 compilers
- Creates releases with auto-incrementing version tags (starting from v1.0.0)
- Runs twice daily to get the latest commits
- Supports manual triggering via workflow_dispatch

## How It Works

1. **Clone Source**: The workflow clones the official Ladybird repository
2. **Install Dependencies**: Installs all required build dependencies for each distribution
3. **Build**: Uses Ladybird's official build script (`./Meta/ladybird.py build`)
4. **Package**: Creates portable binaries with launcher scripts
5. **Release**: Creates GitHub releases with auto-incrementing version tags

## Workflow Features

### Build Matrix
- **Ubuntu**: Built with both GCC 14 and Clang 20 compilers
- **Fedora**: Latest Fedora container with system compiler

### Release Strategy
- Versioning starts at `v1.0.0` and auto-increments patch version
- Each successful build creates a new release with tag (e.g., v1.0.1, v1.0.2)
- Release includes binaries for all supported platforms

### Schedule
- Runs twice daily at 00:00 and 12:00 UTC
- Also triggers on pushes to main/master branches
- Manual triggering available via GitHub UI

## Usage

### Automatic Releases
The workflow automatically creates releases when:
1. Code is pushed to main/master branches
2. Scheduled runs complete successfully
3. Manually triggered via GitHub Actions UI

### Manual Trigger
To manually trigger a build:
1. Go to **Actions** tab in GitHub
2. Select **Build and Release Ladybird Browser**
3. Click **Run workflow**
4. Choose branch and click **Run workflow**

### Artifacts
Each release contains:
- `ladybird-ubuntu-gcc-14/` - Ubuntu build with GCC 14
- `ladybird-ubuntu-clang-20/` - Ubuntu build with Clang 20  
- `ladybird-fedora/` - Fedora build

Each artifact includes:
- Ladybird binary
- Required libraries and resources
- Launcher script (`ladybird-launcher.sh`)

## Installation

1. Download the appropriate archive for your distribution from the Releases page
2. Extract the files
3. Run the launcher script:
   ```bash
   ./ladybird-launcher.sh
   ```

## Requirements

The workflow installs all necessary dependencies automatically:
- Qt6 development packages
- C++23 capable compiler (GCC 14 / Clang 20)
- Build tools (CMake, Ninja, NASM, etc.)
- Audio support (PulseAudio)

## Versioning

The versioning follows semantic versioning:
- **Major**: Breaking changes (manual updates required)
- **Minor**: New features (auto-incremented)
- **Patch**: Bug fixes (auto-incremented)

Starting version: `v1.0.0`

## Repository Structure

```
ladybird-builder/
├── .github/
│   ├── workflows/
│   │   └── build-and-release.yml    # Main workflow file
│   └── workflow-config.json          # Configuration file
├── scripts/
│   ├── version-manager.sh           # Version management
│   └── test-workflow.sh             # Workflow testing
├── README.md                        # Main documentation
└── SETUP.md                         # Setup guide
```

## Contributing

To modify the workflow:
1. Edit `.github/workflows/build-and-release.yml`
2. Test changes in a fork or branch
3. Submit a pull request

## License

This project is licensed under the same license as Ladybird Browser.

## Related Projects

- [Ladybird Browser](https://github.com/LadybirdBrowser/ladybird) - The official Ladybird Browser repository
- [Ladybird Documentation](https://github.com/LadybirdBrowser/ladybird/blob/master/Documentation/BuildInstructionsLadybird.md) - Official build instructions